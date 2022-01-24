# Today's date
truestart="1/16/2022 8:00 am"
fnstart=$(date --date="$truestart" +"%Y-%m-%d-%I%M%p")
start=$(date --date="$truestart")
end=$(date)
# Invoice number
# Format: <Client Number><First Letter of Month><Last Letter of Month><Month Start Number><Day Start Number><Year Start Number>
clientnum="1"
month=$(date +%B)
monthletters="${month:0:1}${month: -1}"
monthcap="${monthletters^^}"
day=$(date +%d --date="$truestart")
year=$(date +%Y --date="$truestart")
invoicenum="$clientnum$monthcap$day${year: -2}"
echo "$invoicenum"
# Strings
br="----------------------------------------------------"
statuslog="updates-made-since-$fnstart.txt"
gitformat="%n[Change #%h]$br%nDate:           %ad%nDescription:    %s%nFiles Affected:"
# Empty file if it exists already.
if [ -f $statuslog ]
then
	> $statuslog
fi

git --no-pager log --name-status --pretty="$gitformat" --since="$start" --until="$end" --abbrev-commit --date=local --reverse --output="$statuslog"

sed -i "1s/^/Invoice #$invoicenum Changelog/" $statuslog
sed -i "2s/^/Start: $start\n/" $statuslog
sed -i "3s/^/End:   $end\n/" $statuslog
sed -i '4s/^/Key:   M=modified, A=added, D=deleted\n\n/' $statuslog
