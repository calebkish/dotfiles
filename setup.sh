#! /usr/bin/env sh

# $1 - Name of user to install packages for; Can be "system" to install system packages
# $2 - Directory containing the packages in relation to directory of setup.sh
# $3 - The packages separated by spaces that you want to install from the specified directory
# $4 - Set to 'y' to turn on preview mode

profile="$1"
dir="$2"
packages="$3"
[ "$4" = 'y' ] && preview='--no' || preview=''

case "$profile" in
	'system') target='/' ;;
	'root') target='/root' ;;
	*) target="/home/$profile" ;;
esac

if [ "$packages" = '*' ]; then
	(
		cd "$dir" || exit
		stow "$preview" --verbose --stow --target "$target" "*"
	)
	exit
fi

echo "$packages" | tr ' ' '\n' | while read -r package; do
	(
		cd "$dir" || exit
		stow "$preview" --verbose --stow --target "$target" "$package"
	)
done
