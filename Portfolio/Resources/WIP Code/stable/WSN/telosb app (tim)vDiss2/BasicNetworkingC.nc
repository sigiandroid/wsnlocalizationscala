#include <Timer.h>
#include <UserButton.h>
#include "printf.h"
#include "BasicNetworking.h"

module BasicNetworkingC {
  uses {
    // initialization
    interface Boot;
	interface SplitControl as RadioControl;
	interface SplitControl as SerialControl;
	interface StdControl as RoutingControlC;
	interface StdControl as RoutingControlL;
	interface StdControl as RoutingControlS;
	interface StdControl as DisseminationControl; // BroadcastControl ???
	
	// Dissemination
	interface DisseminationUpdate<DissMsg_t> as RequestUpdate; // for root
	interface DisseminationValue<DissMsg_t> as RequestValue; // for motes
	
	// Collection
	interface Send as CollectSendC; // to send data to root
	interface Send as CollectSendL; // to send data to root
	interface Send as CollectSendS; // to send data to root
	interface Receive as SnoopC; // forwarding
	interface Receive as SnoopL; // forwarding
	interface Receive as SnoopS; // forwarding
	interface Receive as CollectReceiveC; // data acquired by root
	interface Receive as CollectReceiveL; // data acquired by root
	interface Receive as CollectReceiveS; // data acquired by root
	interface RootControl as RootControlC; // denote root
	interface RootControl as RootControlS; // denote root
	interface RootControl as RootControlL; // denote root
    
	// serial
	interface AMSend as SerialSendC;
	interface AMSend as SerialSendL;
	interface AMSend as SerialSendS;
	interface Receive as SerialReceive;
	interface Packet as UartPacket;
	
	// sensors
	interface Read<uint16_t> as ReadLight;
	interface Read<uint16_t> as ReadTemp;
	interface Read<uint16_t> as ReadHumidity;
	interface Read<uint16_t> as ReadBattery;
	
	// pushbutton
	interface Notify<button_state_t>;
	
	// memory
	interface Queue<message_t *> as UartQueueC; // FIFO
	interface Pool<message_t> as UartPoolC; // get & put
		
	interface Queue<message_t *> as UartQueueL; // FIFO
	interface Pool<message_t> as UartPoolL; // get & put
	
	interface Queue<message_t *> as UartQueueS; // FIFO
	interface Pool<message_t> as UartPoolS; // get & put
	
	interface Queue<message_t *> as RadioQueueC; // FIFO
	interface Pool<message_t> as RadioPoolC; // get & put
	
	interface Queue<message_t *> as RadioQueueL; // FIFO
	interface Pool<message_t> as RadioPoolL; // get & put
	
	interface Queue<message_t *> as RadioQueueS; // FIFO
	interface Pool<message_t> as RadioPoolS; // get & put
	
	// printf
	interface SplitControl as PrintfControl;
	interface PrintfFlush;

	// other
	interface Timer<TMilli>;
	interface Timer<TMilli> as BroadcastTimer;
	interface Leds;
	
	//AN receive & RSSI

	interface CC2420Packet;
	//interface CC2420Config;
	
	//Broadcast
	interface AMSend as BroadcastSend;
	interface Receive as BroadcastReceive;
	
	//Other
	interface Packet as RadioPacket;
  }
}
implementation {
  //declaration of functions
  void Status();
  task void RadioSendTaskL();
  task void RadioSendTaskC();
  task void RadioSendTaskS();
  task void BroadcastTask();
  
  task void SerialSendTaskL();
  task void SerialSendTaskC();
  task void SerialSendTaskS();
  
  static void ReportProblem();
  static void ReportSent();
  static void ReportReceive();
  static void FatalProblem();
  
  // variables for proces
  uint16_t Alpha = 0;
  uint16_t MaxNumMotes = MAXIMUM_NUMBER_MOTES;
  uint16_t WaitS = 0;
  
  //Lenght to determine the type of packets
  uint8_t UartLen;
  uint8_t RadioLen;
  
  //message buffers
  message_t SndMsgC, SndMsgL, SndMsgS, SndMsgB, UartBufC, UartBufL, UartBufS;
  
  //check radio status
  bool FwdBusy, SendBusy, UartBusy, TaskBusy;
  
  //root or not?
  bool Root = FALSE;
  
  // bools for data
  bool LightIsRead = FALSE;
  bool TempIsRead = FALSE;
  bool HumidityIsRead = FALSE;
  bool ButtonIsPressed = FALSE;
  bool VoltageIsRead = FALSE;
  bool reboot = TRUE;
  
  //Message structs
  CollMsg_t LocalCollMsg;
  LocMsg_t LocalLocMsg;
  StatMsg_t LocalStatMsg;
  broadcast_t local;
  
  // reports
  static void ReportProblem() { call Leds.led0Toggle(); }
  static void ReportSent() { call Leds.led1Toggle(); }
  static void ReportReceive() { call Leds.led2Toggle(); }
  static void FatalProblem() { call Leds.led0Toggle();
							   call Leds.led1Toggle();
							   call Leds.led2Toggle();
							   call Timer.stop(); }
  
  //OK
  // initialize radio, serial, network
  event void Boot.booted() 
  {
  
    //initiate other data: Philippe
	//collection message
    LocalCollMsg.moteid = TOS_NODE_ID;
	LocalCollMsg.lightreading = 0;
	LocalCollMsg.tempreading = 0;
	LocalCollMsg.humidityreading = 0;
	LocalCollMsg.button = FALSE;
	LocalCollMsg.type = 1;
	LocalCollMsg.battery = 0;
	
	//Status message
	LocalStatMsg.moteid = TOS_NODE_ID;
	LocalStatMsg.type = 0;
	LocalStatMsg.active = TRUE;
	LocalStatMsg.AN = FALSE;
	LocalStatMsg.posx = 0;
	LocalStatMsg.posy = 0;
	LocalStatMsg.sampleRate = DEFAULT_SAMPLING_PERIOD;
	LocalStatMsg.locRate = DEFAULT_LOC_PERIOD;
	LocalStatMsg.leds = 0;
	LocalStatMsg.power = 31;
	LocalStatMsg.frequency = 26;
	LocalStatMsg.conn = 0;
	if(TOS_NODE_ID == 2)
	{
	LocalStatMsg.AN = TRUE;
	//call BroadcastTimer.startPeriodic(10000);
	}
	
	//Localization message
	LocalLocMsg.moteid = TOS_NODE_ID;
	LocalLocMsg.ANmoteid = TOS_NODE_ID;
	LocalLocMsg.type = 2;
	LocalLocMsg.posx = 0;
	LocalLocMsg.posy = 0;
	LocalLocMsg.RSSI = 0;
	
	//Broadcast message
	local.id = TOS_NODE_ID;
	local.posx = 13;
	local.posy = 37;
	
	call Leds.set(0);
	
	SendBusy = FALSE;
	UartBusy = FALSE;
	
	call Leds.led0Off();
	call Leds.led1Off();
	call Leds.led2Off();
	
	if (call RadioControl.start() != SUCCESS)
	  FatalProblem();
	
	//Routing for Collection protocol
	if (call RoutingControlC.start() != SUCCESS)
	  FatalProblem();
	  
		if (call RoutingControlL.start() != SUCCESS)
	  FatalProblem();
	  
	  	if (call RoutingControlS.start() != SUCCESS)
	  FatalProblem();
	  
	//Routing for Dissemination protocol
	if (call DisseminationControl.start() != SUCCESS)
	  FatalProblem();
	
	if (TOS_NODE_ID == 0) 
	{ // if mote is root
	  Root = TRUE;
	  if (call SerialControl.start() != SUCCESS)
	    FatalProblem();
	}
	else 
	{ // other motes active pushbutton
	  call Notify.enable();
	}
	call PrintfControl.start();
	
	// Send status message if the node is rebooted
	//LocalStatMsg.type = 3;
	//Status(3);
	
	//Test channel
	//call CC2420Config.setChannel(20);
	
  }
  
  //OK
  event void RadioControl.startDone(error_t err) {
    if (err != SUCCESS)
	  FatalProblem();
	else 
	{
	  if (Root)
	  {
	    call RootControlL.setRoot();
		call RootControlS.setRoot();
		call RootControlC.setRoot();
	  }
		//stop running Timers
      if (call BroadcastTimer.isRunning())
	    call BroadcastTimer.stop();
      if (call Timer.isRunning())
	    call Timer.stop();
		//start the sensor timer
	call Timer.startPeriodic(LocalStatMsg.sampleRate); //sensoren
		if(LocalStatMsg.AN == 1)
    call BroadcastTimer.startPeriodic(LocalStatMsg.locRate);
	
	Status();

	}
  }
  
  //OK
  event void RadioControl.stopDone(error_t err) { }
  
  //event void CC2420Config.syncDone(error_t error) {}
  
  //OK
  event void SerialControl.startDone(error_t err) 
  {
    if (err != SUCCESS)
	  FatalProblem();
  }
  
  event void PrintfFlush.flushDone(error_t error){ }
  event void PrintfControl.startDone(error_t error) { }
  event void PrintfControl.stopDone(error_t error) {}
  
  //OK
  event void SerialControl.stopDone(error_t err) { }
  
  //OK
  // pushbutton
  event void Notify.notify(button_state_t state) {
    if (state == BUTTON_PRESSED)
	  LocalCollMsg.button = TRUE;
  }
 

  void Status()
  {

    	if (!Root) 
		{
		
		StatMsg_t *out;
			  
			if (!TaskBusy) 
			{
			  out = (StatMsg_t *)call CollectSendS.getPayload(&SndMsgS);
			  memcpy(out, &LocalStatMsg, sizeof(StatMsg_t));
			  
				printf("Status(): !root && !Taskbusy\n");
			  
			  TaskBusy = TRUE;
			  post RadioSendTaskS();
			}
			else 
			{
			  message_t *NewMsg = call RadioPoolS.get();
			  if (NewMsg == NULL)
				ReportProblem();
			  out = (StatMsg_t *)call CollectSendS.getPayload(NewMsg);
			  memcpy(out, &LocalStatMsg, sizeof(StatMsg_t));
			  if (call RadioQueueS.enqueue(NewMsg) != SUCCESS) {
				call RadioPoolS.put(NewMsg);
				FatalProblem();
			  }
		}
	  }
  } 

  void ProcessRequest(DissMsg_t *NewRequest) {
    //if target mote or broadcast to all motes
	if ((NewRequest->targetid == TOS_NODE_ID) || (NewRequest->targetid == 0xFFFF)) {
	  switch (NewRequest->request) {
	  
	    case SAMPLING_PERIOD:  //rate that sensors get measured
		  LocalStatMsg.sampleRate = NewRequest->parameter;
		  call Timer.stop();
//		  Alpha = SamplingPeriod/(MaxNumMotes+1);
//		  WaitS = (1+TOS_NODE_ID)*Alpha;
//		  call WaitTimer.startOneShot(WaitS);
		  call Timer.startPeriodic(LocalStatMsg.sampleRate);
		  //LocalStatMsg.type = 4;
		  Status();
		  break;
		  
		case LOC_PERIOD: //rate that RSSI is transmitted
			if (LocalStatMsg.AN == TRUE)
			{						
				call BroadcastTimer.stop();
				call BroadcastTimer.startPeriodic(LocalStatMsg.locRate);
				
				LocalStatMsg.locRate = NewRequest->parameter;
			}
			Status();
			break;
			
		case ACTIVE_REQUEST: //Put a node in the active mode
			if(NewRequest->parameter == 1)
			{
				LocalStatMsg.active = TRUE;
				
				if(LocalStatMsg.AN == TRUE)
				call BroadcastTimer.startPeriodic(LocalStatMsg.locRate);
				
			}
			else if(NewRequest->parameter == 0)
			{
				LocalStatMsg.active = FALSE;
				
				if(LocalStatMsg.AN == TRUE)
				call BroadcastTimer.stop();
				
			}
			Status();
			break;
			
		case AN_REQUEST: //Set the node as anchor node
			if(NewRequest->parameter == 1)
			{
				LocalStatMsg.AN = TRUE;
			}
			else if(NewRequest->parameter == 0)
			{
				if (call BroadcastTimer.isRunning())
				call BroadcastTimer.stop();
				
				LocalStatMsg.AN = FALSE;
			}
			Status();
			break;
		
		case LED_REQUEST: //set the leds on
		  call Leds.set(NewRequest->parameter);
		  LocalStatMsg.leds = NewRequest->parameter;
		  //LocalStatMsg.type = 4;
		  Status();
		  break;
		 
		case POWER_REQUEST: //sets the power level
			LocalStatMsg.power = NewRequest->parameter;
			//LocalStatMsg.type = 4;
			Status();
			break;
			
		case FREQUENCY_REQUEST: //sets the frequency
			LocalStatMsg.frequency = NewRequest->parameter;
			//call CC2420Config.setChannel(LocalStatMsg.frequency);
			//LocalStatMsg.type = 4;
			Status();
			break;
			
		case POSX_REQUEST: // sets the x coordinate of the node
			LocalStatMsg.posx = NewRequest->parameter;
			//LocalStatMsg.type = 4;
			Status();
			break;
			
		case POSY_REQUEST: // sets the y coordinate of the node
			LocalStatMsg.posy = NewRequest->parameter;
			//LocalStatMsg.type = 4;
			Status();
			break;
		
		case STATUS_REQUEST: //discovery messages
			//LocalStatMsg.type = 4;
			Status();
			break;
			
		default:
		  break;
	  }
	}
  }
  
  
  // when root receives requests to disseminate
  event message_t* SerialReceive.receive(message_t* Msg, void* Payload, uint8_t Length) {
	DissMsg_t *NewRequest = Payload;
	
			printf("SerialReceive.Receive\n");
			
	
	if (Length == sizeof(DissMsg_t))
	   call RequestUpdate.change(NewRequest);
	   
	call PrintfFlush.flush();
	return Msg;
  }
  
  
  // when done with passing on msg
  event void CollectSendC.sendDone(message_t* Msg, error_t err) {
	if (err == SUCCESS)
	{
	  	  printf("CollectSendC.sendDone == SUCCESS\n");

	}
	else
	ReportProblem();
	  
	SendBusy = FALSE; // Just finished CollectSend, if radioqueue is not empty
	
	if (call RadioQueueC.empty() == FALSE) 
	{
	  message_t *QueueMsg = call RadioQueueC.dequeue();
	  if (QueueMsg == NULL) {
	    FatalProblem();
		return;
	  }
	  memcpy(&SndMsgC, QueueMsg, sizeof(CollMsg_t));
	  if (call RadioPoolC.put(QueueMsg) != SUCCESS) {
	    FatalProblem();
		return;
	  }
	  	printf("RadioSendTaskC van radioqueue\n");
			
	  post RadioSendTaskC();
	}
	
	call PrintfFlush.flush();
	ReportSent();
  }
  
    event void CollectSendL.sendDone(message_t* Msg, error_t err) {
	if (err == SUCCESS)
	{
	  	  printf("CollectSendL.sendDone == SUCCESS\n");
	}
	else
	ReportProblem();
	  
	SendBusy = FALSE; // Just finished CollectSend, if radioqueue is not empty
	
	if (call RadioQueueL.empty() == FALSE) 
	{
	  message_t *QueueMsg = call RadioQueueL.dequeue();
	  if (QueueMsg == NULL) {
	    FatalProblem();
		return;
	  }
	  memcpy(&SndMsgL, QueueMsg, sizeof(LocMsg_t));
	  if (call RadioPoolL.put(QueueMsg) != SUCCESS) {
	    FatalProblem();
		return;
	  }
	  	printf("RadioSendTaskL van de radioQueue\n");
	  post RadioSendTaskL();
	}
	
	call PrintfFlush.flush();
	ReportSent();
  }
  
    event void CollectSendS.sendDone(message_t* Msg, error_t err) {
	if (err == SUCCESS)
	{
	  	  printf("CollectSendS.sendDone == SUCCESS\n");
	}
	else
	ReportProblem();
	  
	SendBusy = FALSE; // Just finished CollectSend, if radioqueue is not empty
	
	if (call RadioQueueS.empty() == FALSE) 
	{
	  message_t *QueueMsg = call RadioQueueS.dequeue();
	  if (QueueMsg == NULL) {
	    FatalProblem();
		return;
	  }
	  memcpy(&SndMsgS, QueueMsg, sizeof(StatMsg_t));
	  if (call RadioPoolS.put(QueueMsg) != SUCCESS) {
	    FatalProblem();
		return;
	  }
	  	printf("RadioSendTaskS van radioqueue\n");
	  
	  post RadioSendTaskS();
	}
	
	call PrintfFlush.flush();
	ReportSent();
  }
  
  // when done forwarding data over serial port (root only)
  event void SerialSendC.sendDone(message_t* Msg, error_t err) {
  	if (err == SUCCESS)
	{
			ReportReceive();
	  	  printf("SerialSendC.sendDone == SUCCESS\n");
		  //call PrintfFlush.flush();
	}
	else
	ReportProblem();
	UartBusy = FALSE; //Just finished SerialSend, if uartqueue is not empty
	if (call UartQueueC.empty() == FALSE) {
	  message_t *QueueMsg = call UartQueueC.dequeue();
	  if (QueueMsg == NULL) {
	    FatalProblem();
		return;
	  }
	  memcpy(&UartBufC, QueueMsg, sizeof(CollMsg_t));
	  if (call UartPoolC.put(QueueMsg) != SUCCESS) {
	    FatalProblem();
		return;
	  }
	  post SerialSendTaskC();
	}
	ReportSent();
	call PrintfFlush.flush();
  }
  
    event void SerialSendL.sendDone(message_t* Msg, error_t err) {
  	if (err == SUCCESS)
	{
			ReportReceive();
	  	  printf("SerialSendL.sendDone == SUCCESS\n");
		  //call PrintfFlush.flush();
	}
	else
	ReportProblem();
	UartBusy = FALSE; //Just finished SerialSend, if uartqueue is not empty
	if (call UartQueueL.empty() == FALSE) {
	  message_t *QueueMsg = call UartQueueL.dequeue();
	  if (QueueMsg == NULL) {
	    FatalProblem();
		return;
	  }
	  memcpy(&UartBufL, QueueMsg, sizeof(LocMsg_t));
	  if (call UartPoolL.put(QueueMsg) != SUCCESS) {
	    FatalProblem();
		return;
	  }
	  post SerialSendTaskL();
	}
	ReportSent();
	call PrintfFlush.flush();
  }
  
    event void SerialSendS.sendDone(message_t* Msg, error_t err) {
  	if (err == SUCCESS)
	{
			ReportReceive();
	  	  printf("SerialSendS.sendDone == SUCCESS\n");
		  //call PrintfFlush.flush();
	}
	else
	ReportProblem();
	UartBusy = FALSE; //Just finished SerialSend, if uartqueue is not empty
	if (call UartQueueS.empty() == FALSE) {
	  message_t *QueueMsg = call UartQueueS.dequeue();
	  if (QueueMsg == NULL) {
	    FatalProblem();
		return;
	  }
	  memcpy(&UartBufS, QueueMsg, sizeof(StatMsg_t));
	  if (call UartPoolS.put(QueueMsg) != SUCCESS) {
	    FatalProblem();
		return;
	  }
	  post SerialSendTaskS();
	}
	ReportSent();
	call PrintfFlush.flush();
  }
  
  // when dissemination passed around a message
  event void RequestValue.changed() {
    DissMsg_t *NewRequest = (DissMsg_t *)call RequestValue.get();
	ProcessRequest(NewRequest);
  }
  
    task void RadioSendTaskS() 
	{
    if (!Root && !SendBusy) 
	{
		//RadioLen = call RadioPacket.payloadLength(&SndMsg);
		
		if (call CollectSendS.send(&SndMsgS, sizeof(StatMsg_t)) == SUCCESS)
		  {
			SendBusy = TRUE;
			TaskBusy = FALSE;		
			printf("StatMsg wordt verzonden\n");
			call PrintfFlush.flush();
		  }
		else
			ReportProblem();
	}
	//LocalCollMsg.button = FALSE;
  }
	
	task void RadioSendTaskC() 
	{
    if (!Root && !SendBusy) 
	{
		//RadioLen = call RadioPacket.payloadLength(&SndMsg);
		
		if (call CollectSendC.send(&SndMsgC, sizeof(CollMsg_t)) == SUCCESS)
		  {
			SendBusy = TRUE;
			TaskBusy = FALSE;			
			//printf("CollMsg wordt verzonden\n");
			//call PrintfFlush.flush();
			  //ReportReceive();
		  }
		else
			ReportProblem();
	}
	LocalCollMsg.button = FALSE;
  }
  
  event void Timer.fired() {
  
	  printf("Timer.fired\n");
	  call PrintfFlush.flush();	
	  
    if (call ReadLight.read() == SUCCESS)
	  LightIsRead = TRUE;
	if (call ReadTemp.read() == SUCCESS)
	  TempIsRead = TRUE;
	if (call ReadHumidity.read() == SUCCESS)
      HumidityIsRead = TRUE;
	if (call ReadBattery.read() == SUCCESS)
      VoltageIsRead = TRUE;
	  
	// when all measurements are done
	if (LightIsRead && TempIsRead && HumidityIsRead && VoltageIsRead) {
	  if (!Root) {
	  
		CollMsg_t *out;
	    if (!SendBusy) 
		{
		  out = (CollMsg_t *)call CollectSendC.getPayload(&SndMsgC);
		  memcpy(out, &LocalCollMsg, sizeof(CollMsg_t));
		  
		  //printf("RadioSendTaskC\n");
		  //call PrintfFlush.flush();		
		  
		  TaskBusy = TRUE;
		  post RadioSendTaskC();

		}
		else 
		{
		  message_t *NewMsg = call RadioPoolC.get();
		  if (NewMsg == NULL)
		    ReportProblem();
		  out = (CollMsg_t *)call CollectSendC.getPayload(NewMsg);
		  memcpy(out, &LocalCollMsg, sizeof(CollMsg_t));
		  if (call RadioQueueC.enqueue(NewMsg) != SUCCESS) 
		  {
		    call RadioPoolC.put(NewMsg);
			FatalProblem();
		  }
		}
	  }
	}
  }
  
  // when sensor has been read
  event void ReadLight.readDone(error_t err, uint16_t reading) {
    if (err != SUCCESS) {
	  reading = 0xFFFF;
	  ReportProblem();
	}
	else 
	{
	  LocalCollMsg.lightreading = reading;
	}    
  }
  
  // when sensor has been read
  event void ReadTemp.readDone(error_t err, uint16_t reading) {
    if (err != SUCCESS) {
	  reading = 0xFFFF;
	  ReportProblem();
	}
	else {
	  LocalCollMsg.tempreading = reading;
	}
  }

  // when sensor has been read
  event void ReadHumidity.readDone(error_t err, uint16_t reading) {
    if (err != SUCCESS) {
	  reading = 0xFFFF;
	  ReportProblem();
	}
	else {
	  LocalCollMsg.humidityreading = reading;
	}
  }  
  
    // when sensor has been read
  event void ReadBattery.readDone(error_t err, uint16_t reading) {
    if (err != SUCCESS) {
	  reading = 0xFFFF;
	  ReportProblem();
	}
	else 
	{
	  LocalCollMsg.battery = reading;
	}
  } 
  
    task void RadioSendTaskL() 
	{
    if (!Root && !SendBusy) 
	{
		//RadioLen = call RadioPacket.payloadLength(&SndMsg);
		//call CC2420Packet.setPower(&SndMsgL,12);
		if (call CollectSendL.send(&SndMsgL, sizeof(LocMsg_t)) == SUCCESS)
		  {
			SendBusy = TRUE;
			TaskBusy = FALSE;			
			printf("LocMsg wordt verzonden\n");
			call PrintfFlush.flush();
		  }
		else
			ReportProblem();
	}
	//LocalCollMsg.button = FALSE;
  }
  
    task void SerialSendTaskC() { 
	
	//UartLen = call UartPacket.payloadLength(&UartBuf);
	UartLen = sizeof(CollMsg_t);
	if (call SerialSendC.send(0xFFFF, &UartBufC, UartLen) == SUCCESS)
	{
		UartBusy = TRUE;
		printf("SerialSend van CollMsg \n");
		call PrintfFlush.flush();
	}
	else
	  ReportProblem();
  }
  
    task void SerialSendTaskL() { 
	
	UartLen = sizeof(LocMsg_t);
	if (call SerialSendL.send(0xFFFF, &UartBufL, UartLen) == SUCCESS)
	{
		UartBusy = TRUE;
		printf("SerialSend van LocMsg \n");
		call PrintfFlush.flush();
	}
	else
	  ReportProblem();
  }
  
    task void SerialSendTaskS() 
	{ 
	
	UartLen = sizeof(StatMsg_t);
	if (call SerialSendS.send(0xFFFF, &UartBufS, UartLen) == SUCCESS)
	{
		UartBusy = TRUE;
		printf("SerialSend van StatMsg \n");

	}
	else
	  ReportProblem();
	  
	call PrintfFlush.flush();
  }
  
    event message_t* CollectReceiveC.receive(message_t* Msg, void* Payload, uint8_t Length) {

    //int packetType = 0;
	CollMsg_t* inColl = (CollMsg_t*)Payload;
	CollMsg_t* outColl;

		printf("CollectReceiveC.receive:\n");
		printf("ID is: %u\n", inColl->moteid);
		printf("Power is: %u\n", call CC2420Packet.getPower(Msg));
	//	printf("Channel: %u\n",call CC2420Packet.getChannel());
		if (UartBusy == FALSE)
		{
			outColl = (CollMsg_t*)call SerialSendC.getPayload(&UartBufC);

			  if (Length != sizeof(CollMsg_t))
				return Msg;
			  else
				memcpy(outColl, inColl, sizeof(CollMsg_t));
			
			post SerialSendTaskC();
		}
		else 
		{
		  // when busy, queue up
		  message_t *NewMsg = call UartPoolC.get();
		  if (NewMsg == NULL) 
		  {
			ReportProblem();
			return Msg;
		  }
		  outColl = (CollMsg_t*)call SerialSendC.getPayload(NewMsg);
		  memcpy(outColl, inColl, sizeof(CollMsg_t));
		  if (call UartQueueC.enqueue(NewMsg) != SUCCESS) {
			call UartPoolC.put(NewMsg);
			FatalProblem();
			return Msg;
		  }
		}
	call PrintfFlush.flush();
	return Msg;
		
  }
  
      event message_t* CollectReceiveL.receive(message_t* Msg, void* Payload, uint8_t Length) {

    //int packetType = 0;
	LocMsg_t* inLoc = (LocMsg_t*)Payload;
	LocMsg_t* outLoc;

		printf("CollectReceiveL.receive:\n");
		printf("ID is: %u\n", inLoc->moteid);
		printf("Power level is: %u\n", call CC2420Packet.getPower(Msg));
//		printf("Channel: %u\n",call CC2420Packet.getChannel());
		
		if (UartBusy == FALSE)
		{
			outLoc = (LocMsg_t*)call SerialSendL.getPayload(&UartBufL);

			  if (Length != sizeof(LocMsg_t))
				return Msg;
			  else
				memcpy(outLoc, inLoc, sizeof(LocMsg_t));
			
			post SerialSendTaskL();
		}
		else 
		{
		  // when busy, queue up
		  message_t *NewMsg = call UartPoolS.get();
		  if (NewMsg == NULL) 
		  {
			ReportProblem();
			return Msg;
		  }
		  outLoc = (LocMsg_t*)call SerialSendL.getPayload(NewMsg);
		  memcpy(outLoc, inLoc, sizeof(LocMsg_t));
		  if (call UartQueueL.enqueue(NewMsg) != SUCCESS) {
			call UartPoolL.put(NewMsg);
			FatalProblem();
			return Msg;
		  }
		}
	call PrintfFlush.flush();
	return Msg;
		
  }
  
    event message_t* CollectReceiveS.receive(message_t* Msg, void* Payload, uint8_t Length) {

    //int packetType = 0;
	StatMsg_t* inStat = (StatMsg_t*)Payload;
	StatMsg_t* outStat;

		printf("CollectReceiveS.receive:\n");
		printf("ID is: %u\n", inStat->moteid);
		printf("Status: type %u\n", inStat->type);
		
		if (UartBusy == FALSE)
		{
			outStat = (StatMsg_t*)call SerialSendS.getPayload(&UartBufS);

			  if (Length != sizeof(StatMsg_t))
				return Msg;
			  else
				memcpy(outStat, inStat, sizeof(StatMsg_t));
			
			post SerialSendTaskS();
		}
		else 
		{
		  // when busy, queue up
		  message_t *NewMsg = call UartPoolS.get();
		  if (NewMsg == NULL) 
		  {
			ReportProblem();
			return Msg;
		  }
		  outStat = (StatMsg_t*)call SerialSendS.getPayload(NewMsg);
		  memcpy(outStat, inStat, sizeof(StatMsg_t));
		  if (call UartQueueL.enqueue(NewMsg) != SUCCESS) {
			call UartPoolL.put(NewMsg);
			FatalProblem();
			return Msg;
		  }
		}
	call PrintfFlush.flush();
	return Msg;
		
  }
  
  //when receiving a broadcasted message
  event message_t* BroadcastReceive.receive(message_t* msg, void* payload, uint8_t len) {
  
  //FatalProblem();
  
  broadcast_t *omsg = (broadcast_t*)payload;
  LocalLocMsg.ANmoteid = omsg->id;
  LocalLocMsg.RSSI = call CC2420Packet.getRssi(msg);
  LocalLocMsg.posx = omsg->posx;
  LocalLocMsg.posy = omsg->posy;
  //call CC2420Packet.getLqi(msg);
  LocalStatMsg.power = call CC2420Packet.getPower(msg);

	printf("BroadcastReceive:\n");
	printf("RSSI: %u\n",LocalLocMsg.RSSI);
	//printf("Power: %u\n",call CC2420Packet.getPower(msg));
//	printf("Channel: %u\n",call CC2420Packet.getChannel());
	printf("Power: %u\n",LocalStatMsg.power);
	call PrintfFlush.flush();
  
  		  //printf("BroadcastReceive.receive\n");
		  //call PrintfFlush.flush();
  
		//alleen blindnode verzend location message
  	  if (!Root && !LocalStatMsg.AN && LocalStatMsg.active) 
	  {
		LocMsg_t *out;
	    if (!SendBusy) 
		{
		  out = (LocMsg_t *)call CollectSendL.getPayload(&SndMsgL);
		  call CC2420Packet.setPower(&SndMsgL,11);
		  memcpy(out, &LocalLocMsg, sizeof(LocMsg_t));
		  TaskBusy = TRUE;
		  post RadioSendTaskL();
		  
		  //TaskBusy = TRUE;
		}
		else 
		{
		  message_t *NewMsg = call RadioPoolL.get();
		  if (NewMsg == NULL)
		    ReportProblem();
		  out = (LocMsg_t *)call CollectSendL.getPayload(NewMsg);
		  memcpy(out, &LocalLocMsg, sizeof(LocMsg_t));
		  if (call RadioQueueL.enqueue(NewMsg) != SUCCESS) 
		  {
		    call RadioPoolL.put(NewMsg);
			FatalProblem();
		  }
		}
	  }
  
  return msg;
  }
  
  task void BroadcastTask()
  {
		//call CC2420Packet.setPower(&SndMsgB,LocalStatMsg.power);
		call CC2420Packet.setPower(&SndMsgB,11);
		if (call BroadcastSend.send(AM_BROADCAST_ADDR, &SndMsgB, sizeof(broadcast_t)) == SUCCESS)
		{
		  SendBusy = TRUE;
		  TaskBusy = FALSE;
		  printf("BroadcastSend.send == SUCCESS\n");
		  call PrintfFlush.flush();
			  //FatalProblem();
		}
		else 
			ReportProblem();

  }
  
  event void BroadcastTimer.fired() {
	//if (!SendBusy && sizeof local <= call BroadcastSend.maxPayloadLength())
		printf("BroadcastTimer.fired\n");
		  call PrintfFlush.flush();	
		  ReportReceive();
	if (!SendBusy && !Root && LocalStatMsg.AN)
	  {
	  	broadcast_t * o = (broadcast_t *)call BroadcastSend.getPayload(&SndMsgB);
			
		memcpy(o, &local, sizeof(broadcast_t));
		call CC2420Packet.setPower(&SndMsgB,11);
		TaskBusy = TRUE;
		post BroadcastTask();
			
	  }
	else
	  ReportProblem();
  }

  event void BroadcastSend.sendDone(message_t* msg, error_t error) {
    if (error == SUCCESS)
	{
      ReportSent();
		printf("BroadcastSend.sendDone\n");
		call PrintfFlush.flush();
	}
    else
      ReportProblem();
    SendBusy = FALSE;
  }
  
  // when forwarding
  event message_t* SnoopC.receive(message_t* Msg, void* Payload, uint8_t Length) {
	return Msg;
  }
    event message_t* SnoopL.receive(message_t* Msg, void* Payload, uint8_t Length) {
	return Msg;
  }
    event message_t* SnoopS.receive(message_t* Msg, void* Payload, uint8_t Length) {
	return Msg;
  }

}