<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'dbwordpress' );

/** MySQL database username */
define( 'DB_USER', 'uwordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'k~IW&_:i)=~}UqCMHhx]wRK.rz[)YjMLnM~p2v8~JW)7]1=]>xhJgOKGk!*EEL%T' );
define( 'SECURE_AUTH_KEY',  'P=B~,L<IR?#OkkX1+:{{EMt_t[EglPv~w#KSs5EL&$p_|aLG5#X;5r~Bj(6F:49j' );
define( 'LOGGED_IN_KEY',    'as3}NKPx][{O;K!c_<dBHMRkcc 8{s(f$mz)U=R]czY<3XdlBmmQGaavp[9X&8~W' );
define( 'NONCE_KEY',        'xu%Ah~!:$-(>PKNft!F&8q5o@SO`Yj_bF;x65@4NgpPTr+}zPElS%&z{ GBZbwrG' );
define( 'AUTH_SALT',        'Ad>E-:8|{%blU3W_peSV<c=OWmeW&9&fu3~V3R/Q*H^?PXk_wA~v5b4@Hy=9ElRl' );
define( 'SECURE_AUTH_SALT', '/Pg~;1>6]qL,]:;R2iEL*3/X~BG*a6na^Fj/.BjN9@%4TsF6^0p3LifUBIt.FY*T' );
define( 'LOGGED_IN_SALT',   '.bPsCs5Wln9F*mE*{>`PU{]~r.dRH9q8vA~D6<oao@Er1jfjhH.{fwJR|ytlVIy+' );
define( 'NONCE_SALT',       '@L %8I0/k[-(/n,|BWfiBkf%48`uhvqnUx7OiI`V%3iMjeo;q-@_T;~ywX5v6m^1' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';