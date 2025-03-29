challengePath="$HOME/volumes/proxy/certbot/challenges/"
letsencryptPath="$HOME/volumes/proxy/certbot/letsencrypt/"
environment='--staging'
email='test@test.test'
proxyType='--nginx'
url=''

handle_help() {
	echo 'use -h to view help (like this :D )'
	echo 'use -a if you use apache'
	echo 'use -p to set the environment to production'
	echo 'use -s to set the service url'
	echo 'use -e to set the email address'
	echo 'use -c to set path to acme challenges'
	echo 'use -l to set path to /etc/letsencrypt of the proxy'
	echo 'remember to set /.well-known/acme-challenge (over http) for the service'
}

main() {
	while getopts "hac:l:ps:e:" flag; do
		case $flag in
		h)
			handle_help
			exit 0
			;;
		a)
			proxyType='--apache'
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

	echo docker run \
		-v "$challengePath":/var/www/html \
		-v "$letsencryptPath":/etc/letsencrypt \
		certbot \
		"certonly $proxyType --agree-tos --no-eff-email --webroot \
		--webroot-path=/var/www/html --email $email $environment -d $url;"
}

main "$@"
