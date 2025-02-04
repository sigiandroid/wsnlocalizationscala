<?php
/**
 * french language file
 *
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author Guy Brand <gb@isis.u-strasbg.fr>
 * @author Delassaux Julien <julien@delassaux.fr>
 * @author Maurice A. LeBlanc <leblancma@cooptel.qc.ca>
 * @author gb@isis.u-strasbg.fr
 * @author stephane.gully@gmail.com
 * @author Guillaume Turri <guillaume.turri@gmail.com>
 */
$lang['menu']                  = 'Paramètres de configuration';
$lang['error']                 = 'Paramètres non modifiés en raison d\'une valeur non valide, vérifiez vos réglages et réessayez. <br />La valeur(s) erronée(s) est entourée d\'une bordure rouge.';
$lang['updated']               = 'Paramètres mis à jour avec succès.';
$lang['nochoice']              = '(aucun autre choix possible)';
$lang['locked']                = 'Le fichier des paramètres ne peut être modifié, si ceci n\'est pas intentionnel, <br /> vérifiez que le nom et les droits du fichier sont corrects.';
$lang['_configuration_manager'] = 'Gestionnaire de configuration';
$lang['_header_dokuwiki']      = 'Paramètres DokuWiki';
$lang['_header_plugin']        = 'Paramètres plugin';
$lang['_header_template']      = 'Paramètres template';
$lang['_header_undefined']     = 'Paramètres indéfinis';
$lang['_basic']                = 'Paramètres de base';
$lang['_display']              = 'Paramètres d\'affichage';
$lang['_authentication']       = 'Paramètres d\'authentification';
$lang['_anti_spam']            = 'Paramètres anti-spam';
$lang['_editing']              = 'Paramètres d\'édition';
$lang['_links']                = 'Paramètres des liens';
$lang['_media']                = 'Paramètres média';
$lang['_advanced']             = 'Paramètres avancés';
$lang['_network']              = 'Paramètres réseaux';
$lang['_plugin_sufix']         = 'Paramètres plugin';
$lang['_template_sufix']       = 'Paramètres template';
$lang['_msg_setting_undefined'] = 'Pas de métadonnée de paramètres.';
$lang['_msg_setting_no_class'] = 'Pas de classe de paramètres.';
$lang['_msg_setting_no_default'] = 'Pas de valeur par défaut.';
$lang['fmode']                 = 'Mode de création des fichiers';
$lang['dmode']                 = 'Mode de création des répertoires';
$lang['lang']                  = 'Langue';
$lang['basedir']               = 'Répertoire de base';
$lang['baseurl']               = 'URL de base';
$lang['savedir']               = 'Répertoire de stockage';
$lang['start']                 = 'Nom de la page d\'accueil';
$lang['title']                 = 'Titre du wiki';
$lang['template']              = 'Template';
$lang['license']               = 'Sous quelle licence doit être placée votre contribution ?';
$lang['fullpath']              = 'Utiliser le chemin complet dans le pied de page';
$lang['recent']                = 'Nombre de derniers changements à afficher';
$lang['breadcrumbs']           = 'Nombre de traces à afficher';
$lang['youarehere']            = 'Traces hiérarchiques';
$lang['typography']            = 'Effectuer des améliorations typographiques';
$lang['htmlok']                = 'Permettre html dans les pages';
$lang['phpok']                 = 'Permettre php dans les pages';
$lang['dformat']               = 'Format de date (cf. fonction <a href="http://www.php.net/strftime">strftime</a> de PHP)';
$lang['signature']             = 'Signature';
$lang['toptoclevel']           = 'Niveau supérieur pour figurer dans la table des matières';
$lang['tocminheads']           = 'Nombre minimum de titres pour qu\'une table des matières soit construite';
$lang['maxtoclevel']           = 'Niveau maximum pour figurer dans la table des matières';
$lang['maxseclevel']           = 'Niveau maximum pour éditer des sections';
$lang['camelcase']             = 'Utiliser CamelCase pour les liens';
$lang['deaccent']              = 'Retirer les accents dans les noms de pages';
$lang['useheading']            = 'Utiliser le titre de premier niveau';
$lang['refcheck']              = 'Vérifier les références de media';
$lang['refshow']               = 'Nombre de références de media à montrer';
$lang['allowdebug']            = 'Debug (<b>Ne l\'activez que si vous en avez besoin !</b>)';
$lang['usewordblock']          = 'Bloquer le spam selon les mots utilisés';
$lang['indexdelay']            = 'Délai avant l\'indexation (sec)';
$lang['relnofollow']           = 'Utiliser rel="nofollow" sur les liens extérieurs';
$lang['mailguard']             = 'Brouiller les adresses de courriel';
$lang['iexssprotect']          = 'Vérifier la présence de code JavaScript ou HTML malveillant dans les fichiers envoyés';
$lang['useacl']                = 'Utiliser les listes de contrôle d\'accès (ACL)';
$lang['autopasswd']            = 'Auto-générer les mots de passe';
$lang['authtype']              = 'Mécanisme d\'authentification';
$lang['passcrypt']             = 'Méthode de cryptage des mots de passe';
$lang['defaultgroup']          = 'Groupe par défaut';
$lang['superuser']             = 'Superuser - groupe, utilisateur ou liste séparée par des virgules user1,@group1,user2 ayant un accès complet à toutes les pages quelquesoit le paramétrage des ACL';
$lang['manager']               = 'Manager - groupe, utilisateur ou liste séparée par des virgules user1,@group1,user2 ayant accès à certaines fonctions de gestion';
$lang['profileconfirm']        = 'Confirmer par mot de passe les modifications de profil';
$lang['disableactions']        = 'Actions à désactiver dans DokuWiki';
$lang['disableactions_check']  = 'Vérifier';
$lang['disableactions_subscription'] = 'Abonnement aux pages';
$lang['disableactions_nssubscription'] = 'Abonnement aux catégories';
$lang['disableactions_wikicode'] = 'Afficher source';
$lang['disableactions_other']  = 'Autres actions (séparées par des virgules)';
$lang['sneaky_index']          = 'Par défaut, DokuWiki affichera toutes les catégories dans la vue par index. Activer cette option permet de cacher celles pour lesquelles l\'utilisateur n\'a pas la permission de lecture. Il peut en résulter le masquage de sous-catégories accessibles. Ceci peut rendre l\'index inutilisable avec certaines ACL.';
$lang['auth_security_timeout'] = 'Délai d\'expiration de sécurité (secondes)';
$lang['securecookie']          = 'Les cookies mis via HTTPS doivent-ils n\'être envoyé par le navigateur que via HTTPS ? Ne désactivez cette option que si la connexion à votre wiki est sécurisée avec SSL mais que la navigation sur le wiki n\'est pas sécurisée';
$lang['updatecheck']           = 'Vérifier les mises à jour ? DokuWiki doit pouvoir contacter splitbrain.org.';
$lang['userewrite']            = 'URLs esthétiques';
$lang['useslash']              = 'Utiliser slash comme séparateur de catégorie dans les URLs';
$lang['usedraft']              = 'Enregistrer automatiquement un brouillon pendant l\'édition';
$lang['sepchar']               = 'Séparateur de nom de page';
$lang['canonical']             = 'Utiliser des URLs canoniques';
$lang['autoplural']            = 'Rechercher les formes plurielles dans les liens';
$lang['compression']           = 'Méthode de compression pour les fichiers dans attic';
$lang['cachetime']             = 'Âge maximum d\'un fichier en cache (sec)';
$lang['locktime']              = 'Âge maximum des fichiers verrous (sec)';
$lang['fetchsize']             = 'Taille maximale (en octets) du fichier que fetch.php peut télécharger';
$lang['notify']                = 'Notifier les modifications à cette adresse de courriel';
$lang['registernotify']        = 'Envoyer un courriel annonçant les nouveaux utilisateurs enregistrés à cette adresse';
$lang['mailfrom']              = 'Expéditeur des notifications par courriel du wiki';
$lang['gzip_output']           = 'Utiliser Content-Encoding gzip pour xhtml';
$lang['gdlib']                 = 'Version de GD Lib';
$lang['im_convert']            = 'Chemin vers l\'outil de conversion d\'ImageMagick';
$lang['jpg_quality']           = 'Qualité de la compression JPG (0-100)';
$lang['subscribers']           = 'Activer l\'abonnement aux pages';
$lang['compress']              = 'Compresser CSS & javascript';
$lang['hidepages']             = 'Cacher les pages correspondant à (expression régulière)';
$lang['send404']               = 'Renvoyer "HTTP 404/Page Not Found" pour les pages introuvables';
$lang['sitemap']               = 'Générer une carte google du site tous les (jours)';
$lang['broken_iua']            = 'La fonction ignore_user_abort est-elle opérationnelle sur votre système ? Ceci peut empêcher le fonctionnement de l\'index de recherche. IIS+PHP/
CGI dysfonctionne. Voir le <a href="http://bugs.splitbrain.org/?do=details&amp;task_id=852">bug 852</a> pour plus d\'info.';
$lang['xsendfile']             = 'Utiliser l\'en-tête X-Sendfile pour permettre au serveur Web de délivrer des fichiers statiques ? Votre serveur Web doit supporter cette fonctionnalité.';
$lang['xmlrpc']                = 'Activer l\'interface XML-RPC.';
$lang['renderer_xhtml']        = 'Moteur de rendu du format de sortie principal (xhtml)';
$lang['renderer__core']        = '%s (dokuwiki core)';
$lang['renderer__plugin']      = '%s (plugin)';
$lang['rememberme']            = 'Permettre de conserver de manière permanente les cookies de connexion (mémoriser)';
$lang['rss_type']              = 'Type de flux RSS';
$lang['rss_linkto']            = 'Lien du flux RSS vers';
$lang['rss_content']           = 'Quel contenu afficher dans le flux RSS ?';
$lang['rss_update']            = 'Fréquence de mise à jour du flux RSS (sec)';
$lang['recent_days']           = 'Signaler les pages modifiées depuis (jours)';
$lang['rss_show_summary']      = 'Le flux XML affiche le résumé dans le titre';
$lang['target____wiki']        = 'Target pour liens internes';
$lang['target____interwiki']   = 'Target pour liens interwiki';
$lang['target____extern']      = 'Target pour liens externes';
$lang['target____media']       = 'Target pour liens media';
$lang['target____windows']     = 'Target pour liens windows';
$lang['proxy____host']         = 'Proxy - hôte';
$lang['proxy____port']         = 'Proxy - port';
$lang['proxy____user']         = 'Proxy - identifiant';
$lang['proxy____pass']         = 'Proxy - mot de passe';
$lang['proxy____ssl']          = 'Proxy - utilisation de ssl';
$lang['safemodehack']          = 'Activer l\'option safemode';
$lang['ftp____host']           = 'FTP - hôte pour safemode';
$lang['ftp____port']           = 'FTP - port pour safemode';
$lang['ftp____user']           = 'FTP - identifiant pour safemode';
$lang['ftp____pass']           = 'FTP - mot de passe pour safemode';
$lang['ftp____root']           = 'FTP - répertoire racine pour safemode';
$lang['license_o_']            = 'Aucune choisie';
$lang['typography_o_0']        = 'aucun';
$lang['typography_o_1']        = 'guillemets uniquement';
$lang['typography_o_2']        = 'tout signe typographique (peut ne pas fonctionner)';
$lang['userewrite_o_0']        = 'aucun';
$lang['userewrite_o_1']        = '.htaccess';
$lang['userewrite_o_2']        = 'DokuWiki';
$lang['deaccent_o_0']          = 'off';
$lang['deaccent_o_1']          = 'supprimer les accents';
$lang['deaccent_o_2']          = 'convertir en roman';
$lang['gdlib_o_0']             = 'GD Lib non disponible';
$lang['gdlib_o_1']             = 'version 1.x';
$lang['gdlib_o_2']             = 'auto-détectée';
$lang['rss_type_o_rss']        = 'RSS 0.91';
$lang['rss_type_o_rss1']       = 'RSS 1.0';
$lang['rss_type_o_rss2']       = 'RSS 2.0';
$lang['rss_type_o_atom']       = 'Atom 0.3';
$lang['rss_type_o_atom1']      = 'Atom 1.0';
$lang['rss_content_o_abstract'] = 'Résumé';
$lang['rss_content_o_diff']    = 'Diff Unifié';
$lang['rss_content_o_htmldiff'] = 'Diff formaté en table HTML';
$lang['rss_content_o_html']    = 'page complète au format HTML';
$lang['rss_linkto_o_diff']     = 'liste des différences';
$lang['rss_linkto_o_page']     = 'page révisée';
$lang['rss_linkto_o_rev']      = 'liste des révisions';
$lang['rss_linkto_o_current']  = 'page actuelle';
$lang['compression_o_0']       = 'aucune';
$lang['compression_o_gz']      = 'gzip';
$lang['compression_o_bz2']     = 'bz2';
$lang['xsendfile_o_0']         = 'ne pas utiliser';
$lang['xsendfile_o_1']         = 'Entête propriétaire lighttpd (avant la version 1.5)';
$lang['xsendfile_o_2']         = 'Entête standard X-Sendfile';
$lang['xsendfile_o_3']         = 'En-tête propriétaire Nginx X-Accel-Redirect';
$lang['showuseras_o_loginname'] = 'Nom d\'utilisateur';
$lang['showuseras_o_username'] = 'Nom complet de l\'utilisateur';
$lang['showuseras_o_email_link'] = 'Courriel de l\'utilisateur en tant que lien mailto:';
$lang['useheading_o_0']        = 'Jamais';
$lang['useheading_o_navigation'] = 'Navigation seulement';
$lang['useheading_o_content']  = 'Contenu du wiki seulement';
$lang['useheading_o_1']        = 'Toujours';
