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
define( 'DB_NAME', getenv('WP_DB_NAME') );
define( 'DB_USER', getenv('WP_DB_USER') );
define( 'DB_PASSWORD', getenv('WP_DB_PASSWORD') );
define( 'DB_CONNECTION_HOST', 'mariadb' ); // Assuming 'mariadb' is your database service name in docker-compose
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// ** Authentication Unique Keys and Salts ** //
define( 'AUTH_KEY',         '):Uw9 :|7$m3yy=c^IM%d8}zG6yXY%25SDUyr.r#GcDP)[b25Yn$sDLNwR~I=kwq' );
define( 'SECURE_AUTH_KEY',  'lBWxAzhu=StQ(s-[t_D8yH8_`0NiM~d[m q<{Hri]n#UM3J;@x[ne;,k<~cN`~%,' );
define( 'LOGGED_IN_KEY',    ' /e+%ecWs`>hA<s`|+7rmujt>3MA}GD*n=D7W%$8h*Xc!jP?hn+fw0#;;g{Ywl@k' );
define( 'NONCE_KEY',        ' -cX{xQc|GjD$=kXd,|lUX5)*oT)ru3^px-iU{q;`1If22EqIwA0/lPIIbpbtB=C' );
define( 'AUTH_SALT',        'U9LX s1@q6$[*VV,MUhL7tS@;I9t_u*uDQIfZdG.ei1Amy$*.RI_TSTz#y=X.>Wq' );
define( 'SECURE_AUTH_SALT', '0<MR&l4v=cZ)8Ke/#ip>2<Ed@ j<#pvLaOMc-jEFM9^tr`X*T2qDIB@)gg.0<e2V' );
define( 'LOGGED_IN_SALT',   'xSHh4B]r[~)h%n$f(dCt;mD}#q gy$<{ >qGgPS>XH*]jH>W<!10>H<_16l{(OdP' );
define( 'NONCE_SALT',       '7Ea$kvU|lkO8&X]b7^#K+w! lH2)SOelLiaYYX(Zz)Ebk_]-#m,J&aM<*JedFa| ' );

// ** Redis Cache settings ** //
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_CACHE', true );

// ** WordPress Database Table prefix ** //
$table_prefix = 'wp_';

// ** Debugging mode ** //
define( 'WP_DEBUG', true );

/* Absolute path to the WordPress directory */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files */
require_once ABSPATH . 'wp-settings.php';
?>
