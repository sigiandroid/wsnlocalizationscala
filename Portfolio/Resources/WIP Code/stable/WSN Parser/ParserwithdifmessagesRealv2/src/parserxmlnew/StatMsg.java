/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package parserxmlnew;

/**
 *
 * @author Poseidon
 */
public class StatMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 17;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 130;

    /** Create a new StatMsg of size 17. */
    public StatMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new StatMsg of the given data_length. */
    public StatMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new StatMsg with the given data_length
     * and base offset.
     */
    public StatMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new StatMsg using the given byte array
     * as backing store.
     */
    public StatMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new StatMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public StatMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new StatMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public StatMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new StatMsg embedded in the given message
     * at the given base offset.
     */
    public StatMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new StatMsg embedded in the given message
     * at the given base offset and length.
     */
    public StatMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <StatMsg> \n";
      try {
        s += "  [moteid=0x"+Long.toHexString(get_moteid())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [type=0x"+Long.toHexString(get_type())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [active=0x"+Long.toHexString(get_active())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [AN=0x"+Long.toHexString(get_AN())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [posx=0x"+Long.toHexString(get_posx())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [posy=0x"+Long.toHexString(get_posy())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [sampleRate=0x"+Long.toHexString(get_sampleRate())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [locRate=0x"+Long.toHexString(get_locRate())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [leds=0x"+Long.toHexString(get_leds())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [power=0x"+Long.toHexString(get_power())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [frequency=0x"+Long.toHexString(get_frequency())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [conn=0x"+Long.toHexString(get_conn())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: moteid
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'moteid' is signed (false).
     */
    public static boolean isSigned_moteid() {
        return false;
    }

    /**
     * Return whether the field 'moteid' is an array (false).
     */
    public static boolean isArray_moteid() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'moteid'
     */
    public static int offset_moteid() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'moteid'
     */
    public static int offsetBits_moteid() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'moteid'
     */
    public int get_moteid() {
        return (int)getUIntBEElement(offsetBits_moteid(), 16);
    }

    /**
     * Set the value of the field 'moteid'
     */
    public void set_moteid(int value) {
        setUIntBEElement(offsetBits_moteid(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'moteid'
     */
    public static int size_moteid() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'moteid'
     */
    public static int sizeBits_moteid() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: type
    //   Field type: short, unsigned
    //   Offset (bits): 16
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'type' is signed (false).
     */
    public static boolean isSigned_type() {
        return false;
    }

    /**
     * Return whether the field 'type' is an array (false).
     */
    public static boolean isArray_type() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'type'
     */
    public static int offset_type() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'type'
     */
    public static int offsetBits_type() {
        return 16;
    }

    /**
     * Return the value (as a short) of the field 'type'
     */
    public short get_type() {
        return (short)getUIntBEElement(offsetBits_type(), 8);
    }

    /**
     * Set the value of the field 'type'
     */
    public void set_type(short value) {
        setUIntBEElement(offsetBits_type(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'type'
     */
    public static int size_type() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'type'
     */
    public static int sizeBits_type() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: active
    //   Field type: byte, unsigned
    //   Offset (bits): 24
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'active' is signed (false).
     */
    public static boolean isSigned_active() {
        return false;
    }

    /**
     * Return whether the field 'active' is an array (false).
     */
    public static boolean isArray_active() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'active'
     */
    public static int offset_active() {
        return (24 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'active'
     */
    public static int offsetBits_active() {
        return 24;
    }

    /**
     * Return the value (as a byte) of the field 'active'
     */
    public byte get_active() {
        return (byte)getSIntBEElement(offsetBits_active(), 8);
    }

    /**
     * Set the value of the field 'active'
     */
    public void set_active(byte value) {
        setSIntBEElement(offsetBits_active(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'active'
     */
    public static int size_active() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'active'
     */
    public static int sizeBits_active() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: AN
    //   Field type: byte, unsigned
    //   Offset (bits): 32
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'AN' is signed (false).
     */
    public static boolean isSigned_AN() {
        return false;
    }

    /**
     * Return whether the field 'AN' is an array (false).
     */
    public static boolean isArray_AN() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'AN'
     */
    public static int offset_AN() {
        return (32 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'AN'
     */
    public static int offsetBits_AN() {
        return 32;
    }

    /**
     * Return the value (as a byte) of the field 'AN'
     */
    public byte get_AN() {
        return (byte)getSIntBEElement(offsetBits_AN(), 8);
    }

    /**
     * Set the value of the field 'AN'
     */
    public void set_AN(byte value) {
        setSIntBEElement(offsetBits_AN(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'AN'
     */
    public static int size_AN() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'AN'
     */
    public static int sizeBits_AN() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: posx
    //   Field type: int, unsigned
    //   Offset (bits): 40
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'posx' is signed (false).
     */
    public static boolean isSigned_posx() {
        return false;
    }

    /**
     * Return whether the field 'posx' is an array (false).
     */
    public static boolean isArray_posx() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'posx'
     */
    public static int offset_posx() {
        return (40 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'posx'
     */
    public static int offsetBits_posx() {
        return 40;
    }

    /**
     * Return the value (as a int) of the field 'posx'
     */
    public int get_posx() {
        return (int)getUIntBEElement(offsetBits_posx(), 16);
    }

    /**
     * Set the value of the field 'posx'
     */
    public void set_posx(int value) {
        setUIntBEElement(offsetBits_posx(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'posx'
     */
    public static int size_posx() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'posx'
     */
    public static int sizeBits_posx() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: posy
    //   Field type: int, unsigned
    //   Offset (bits): 56
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'posy' is signed (false).
     */
    public static boolean isSigned_posy() {
        return false;
    }

    /**
     * Return whether the field 'posy' is an array (false).
     */
    public static boolean isArray_posy() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'posy'
     */
    public static int offset_posy() {
        return (56 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'posy'
     */
    public static int offsetBits_posy() {
        return 56;
    }

    /**
     * Return the value (as a int) of the field 'posy'
     */
    public int get_posy() {
        return (int)getUIntBEElement(offsetBits_posy(), 16);
    }

    /**
     * Set the value of the field 'posy'
     */
    public void set_posy(int value) {
        setUIntBEElement(offsetBits_posy(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'posy'
     */
    public static int size_posy() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'posy'
     */
    public static int sizeBits_posy() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: sampleRate
    //   Field type: int, unsigned
    //   Offset (bits): 72
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'sampleRate' is signed (false).
     */
    public static boolean isSigned_sampleRate() {
        return false;
    }

    /**
     * Return whether the field 'sampleRate' is an array (false).
     */
    public static boolean isArray_sampleRate() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'sampleRate'
     */
    public static int offset_sampleRate() {
        return (72 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'sampleRate'
     */
    public static int offsetBits_sampleRate() {
        return 72;
    }

    /**
     * Return the value (as a int) of the field 'sampleRate'
     */
    public int get_sampleRate() {
        return (int)getUIntBEElement(offsetBits_sampleRate(), 16);
    }

    /**
     * Set the value of the field 'sampleRate'
     */
    public void set_sampleRate(int value) {
        setUIntBEElement(offsetBits_sampleRate(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'sampleRate'
     */
    public static int size_sampleRate() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'sampleRate'
     */
    public static int sizeBits_sampleRate() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: locRate
    //   Field type: int, unsigned
    //   Offset (bits): 88
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'locRate' is signed (false).
     */
    public static boolean isSigned_locRate() {
        return false;
    }

    /**
     * Return whether the field 'locRate' is an array (false).
     */
    public static boolean isArray_locRate() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'locRate'
     */
    public static int offset_locRate() {
        return (88 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'locRate'
     */
    public static int offsetBits_locRate() {
        return 88;
    }

    /**
     * Return the value (as a int) of the field 'locRate'
     */
    public int get_locRate() {
        return (int)getUIntBEElement(offsetBits_locRate(), 16);
    }

    /**
     * Set the value of the field 'locRate'
     */
    public void set_locRate(int value) {
        setUIntBEElement(offsetBits_locRate(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'locRate'
     */
    public static int size_locRate() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'locRate'
     */
    public static int sizeBits_locRate() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: leds
    //   Field type: short, unsigned
    //   Offset (bits): 104
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'leds' is signed (false).
     */
    public static boolean isSigned_leds() {
        return false;
    }

    /**
     * Return whether the field 'leds' is an array (false).
     */
    public static boolean isArray_leds() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'leds'
     */
    public static int offset_leds() {
        return (104 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'leds'
     */
    public static int offsetBits_leds() {
        return 104;
    }

    /**
     * Return the value (as a short) of the field 'leds'
     */
    public short get_leds() {
        return (short)getUIntBEElement(offsetBits_leds(), 8);
    }

    /**
     * Set the value of the field 'leds'
     */
    public void set_leds(short value) {
        setUIntBEElement(offsetBits_leds(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'leds'
     */
    public static int size_leds() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'leds'
     */
    public static int sizeBits_leds() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: power
    //   Field type: short, unsigned
    //   Offset (bits): 112
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'power' is signed (false).
     */
    public static boolean isSigned_power() {
        return false;
    }

    /**
     * Return whether the field 'power' is an array (false).
     */
    public static boolean isArray_power() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'power'
     */
    public static int offset_power() {
        return (112 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'power'
     */
    public static int offsetBits_power() {
        return 112;
    }

    /**
     * Return the value (as a short) of the field 'power'
     */
    public short get_power() {
        return (short)getUIntBEElement(offsetBits_power(), 8);
    }

    /**
     * Set the value of the field 'power'
     */
    public void set_power(short value) {
        setUIntBEElement(offsetBits_power(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'power'
     */
    public static int size_power() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'power'
     */
    public static int sizeBits_power() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: frequency
    //   Field type: short, unsigned
    //   Offset (bits): 120
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'frequency' is signed (false).
     */
    public static boolean isSigned_frequency() {
        return false;
    }

    /**
     * Return whether the field 'frequency' is an array (false).
     */
    public static boolean isArray_frequency() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'frequency'
     */
    public static int offset_frequency() {
        return (120 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'frequency'
     */
    public static int offsetBits_frequency() {
        return 120;
    }

    /**
     * Return the value (as a short) of the field 'frequency'
     */
    public short get_frequency() {
        return (short)getUIntBEElement(offsetBits_frequency(), 8);
    }

    /**
     * Set the value of the field 'frequency'
     */
    public void set_frequency(short value) {
        setUIntBEElement(offsetBits_frequency(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'frequency'
     */
    public static int size_frequency() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'frequency'
     */
    public static int sizeBits_frequency() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: conn
    //   Field type: short, unsigned
    //   Offset (bits): 128
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'conn' is signed (false).
     */
    public static boolean isSigned_conn() {
        return false;
    }

    /**
     * Return whether the field 'conn' is an array (false).
     */
    public static boolean isArray_conn() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'conn'
     */
    public static int offset_conn() {
        return (128 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'conn'
     */
    public static int offsetBits_conn() {
        return 128;
    }

    /**
     * Return the value (as a short) of the field 'conn'
     */
    public short get_conn() {
        return (short)getUIntBEElement(offsetBits_conn(), 8);
    }

    /**
     * Set the value of the field 'conn'
     */
    public void set_conn(short value) {
        setUIntBEElement(offsetBits_conn(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'conn'
     */
    public static int size_conn() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'conn'
     */
    public static int sizeBits_conn() {
        return 8;
    }

}