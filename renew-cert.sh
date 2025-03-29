challengePath="$HOME/volumes/proxy/certbot/challenges/"
letsencryptPath="$HOME/volumes/proxy/certbot/letsencrypt/"
environment='--staging'
dryRun='--dryRun'
url=''

handle_help() {
	echo 'use -h to view help (like this :D )'
	echo 'use -p to set the environment to production'
	echo 'use -r to run the renew against the live server'
	echo 'use -s to set the service CERTIFICATE name (not setting it results in renewing all certs)'
	echo 'use -c to set path to acme challenges'
	echo 'use -l to set path to /etc/letsencrypt of the proxy'
	echo 'use -d to enter debug (echo the last commands)'
	echo 'remember to set /.well-known/acme-challenge (over http) for the service'
}

main() {
	while getopts "hac:l:prs:d" flag; do
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
		r)
			dryRun=''
			;;
		s)
			url="--cert-name $OPTARG"
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
		-c "/bin/sh -c 'certbot renew webroot \
		--webroot-path=/var/www/html $environment $dryRun $url; \
		cat /var/log/letsencrypt/letsencrypt.log'"
}

main "$@"
