# FT_SERVER

This is the ft_server project from school 42. The goal of this project is to use Docker (in the wrong way but it doesn't matter) to create an image that contains a web server, SQL server, WordPress and PHPMyAdmin.

## Usage

To compile it, just run : 
``` bash
docker build -t ft_server .
```

##### File details
| File              | Usage                                                                                                          |
|:-----------------:|----------------------------------------------------------------------------------------------------------------|
| `dbwordpress.sql` | WordPress Database                                                                                             |
| `launch.sh`       | Container entry point to handle environment variables, launch different services and keep the container alive. |
| `localhost.conf`  | Configuration file for NGINX.                                                                                  |
| `wp-config.php`   | Configuration file for WordPress.                                                                              |

##### Environment variables
| Environment variables  | Default      | Values            | Effects                                                                                                                      |
|:----------------------:|:------------:|:-----------------:|------------------------------------------------------------------------------------------------------------------------------|
| `AUTO_INDEX`           | `ON`        | `ON/OFF/EMPTY`    | If `NO` change line in nginx conf for disable `autoindex`.                                                                   |
| `DEV_CERT`             | `NO`         | `YES/NO/EMPTY`    | If on `YES` will use `cert_dev.pem` and `key_dev.pem`from srcs folder. Otherwise it will generate certificates and use them. |
| `SQL_USERNAME`         | `uwordpress` | Whatever you want | Will change the SQL username in MySQL ans WP conf                                                                            |
| `SQL_PASSWORD`         | `password`   | Whatever you want | Will change the SQL password in MySQL ans WP conf                                                                            |
| `WP_USERNAME`          | `admin`      | Whatever you want | Will change the admin username for WP connection                                                                             |
| `WP_PASSWORD`          | `password`   | Whatever you want | Will change the admin password for WP connection                                                                             |

##### Ports in use
| Ports | Usage                         |
|:-----:|-------------------------------|
| `80`  | Used for the HTTP web server  |
| `443` | Used for the HTTPS web server |


## Examples

To start the container with the default parameters :
``` bash
docker run -d -p 80:80 -p 443:443 --name ft_server ft_server
```

To start the container with your configuration :
```bash
docker run -d --name ft_server      \
    -p 80:80 -p 443:443             \
    -e AUTO_INDEX="OFF"             \
    -e DEV_CERT="YES"               \
    -e SQL_USERNAME="marvin"        \
    -e SQL_PASSWORD="super"         \
    -e WP_USERNAME="norminet"       \
    -e WP_PASSWORD="bonr2code"      \
    ft_server
```