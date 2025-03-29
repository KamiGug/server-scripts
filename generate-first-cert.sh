challengePath="$HOME/volumes/proxy/certbot/challenges/"
letsencryptPath="$HOME/volumes/proxy/certbot/letsencrypt/"
environment='--staging'
email='test@test.test'
url=''
debug=''

handle_help() {
	echo 'use -h to view help (like this :D )'
	echo 'use -p to set the environment to production'
	echo 'use -s to set the service url'
	echo 'use -e to set the email address'
	echo 'use -c to set path to acme challenges'
	echo 'use -l to set path to /etc/letsencrypt of the proxy'
	echo 'use -d to enter debug (echo the last commands)'
	echo 'remember to set /.well-known/acme-challenge (over http) for the service'
}

main() {
	while getopts "hac:l:ps:e:d" flag; do
		case $flag in
		h)
			handle_help
			exit 0
			;;
		c)
			challengePath=$OPTARG
			;;
		l)
			letsencryptPath=$OPTARG
			;;
		p)
			environment=''
			;;
		s)
			url=$OPTARG
			;;
		e)
			email=$OPTARG
			;;
		d)
			debug="echo "
			;;
		?)
			echo "flag -$OPTARG is not implemented" >>/dev/stderr
			handle_help
			;;
		esac
	done
	if [ -z "${url}" ]; then
		echo "missing service url!" >>/dev/stderr
		handle_help
		exit 10
	fi
	if [ ! -d "${challengePath}" ]; then
		echo "${challengePath} is not a directory (tried to use it as challengePath)" >>/dev/stderr
		exit 100
	fi

	if [ ! -d "${letsencryptPath}" ]; then
		echo "${letsencryptPath} is not a directory (tried to use it as letsencryptPath)" >>/dev/stderr
		exit 101
	fi

	$debug docker run --entrypoint=/bin/sh --rm \
		-v "$challengePath":/var/www/html \
		-v "$letsencryptPath":/etc/letsencrypt \
		certbot/certbot \
		-c "'/bin/sh -c 'certbot certonly --webroot --webroot-path=/var/www/html --email $email --agree-tos --no-eff-email $environment -d $url; cat /var/log/letsencrypt/letsencrypt.log''"
}

main "$@"
