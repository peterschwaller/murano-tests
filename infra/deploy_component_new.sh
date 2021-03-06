###
### Use:
###   expect deploy_component.sh user 10.10.10.10 /refs/for/master/344332 murano-api
###

set timeout 1200

send_user "\n\nStart to login to the test bed...\n\n"

spawn /usr/bin/ssh  [lindex $argv 0]@[lindex $argv 1]
expect "@murano"

send -- "sudo su\n"
expect "@murano"

send -- "rm -rf /tmp/keystone-signing-muranoapi\n"
expect "@murano"
send -- "rm -rf /tmp/keystone-signing-muranorepository\n"
expect "@murano"

send -- "cd /opt/git/ && rm -rf "
send -- [lindex $argv 3]
send -- "\n"
expect "@murano"

send -- "git clone https://github.com/stackforge/"
send -- [lindex $argv 3]
send -- "\n"
expect "@murano"

send -- "cd /opt/git/"
send -- [lindex $argv 3]
send -- "\n"
expect "@murano"

send -- "bash setup.sh uninstall > 2.log\n"
expect "@murano"

send -- "git fetch https://review.openstack.org/stackforge/"
send -- [lindex $argv 3]
send -- " "
send -- [lindex $argv 2]
send -- " && git checkout FETCH_HEAD\n"
expect "@murano"

send -- "chown horizon:horizon /var/lib/openstack-dashboard/secret_key\n"
expect "@murano"
send -- "chmod 600 /var/lib/openstack-dashboard/secret_key\n"
expect "@murano"

send -- "bash setup.sh install > old.log\n"
expect "@murano"

send -- "service openstack-"
send -- [lindex $argv 3]
send -- " restart\n"
expect "@murano"
send -- "service "
send -- [lindex $argv 3]
send -- " restart\n"
expect "@murano"

send -- "cd /var/cache/murano/muranorepository-data && rm -rf *\n"
expect "@murano"
send -- "cd /var/cache/murano-dashboard/ && rm -rf *\n"
expect "@murano"
send -- "cd /var/cache/murano/muranoconductor-data && rm -rf *\n"
expect "@murano"

send -- "service murano-api restart\n"
expect "@murano"
send -- "service murano-conductor restart\n"
expect "@murano"
send -- "service murano-repository restart\n"
expect "@murano"
send -- "service openstack-murano-api restart\n"
expect "@murano"
send -- "service openstack-murano-conductor restart\n"
expect "@murano"
send -- "service openstack-murano-repository restart\n"
expect "@murano"
send -- "service apache2 restart\n"
expect "@murano"

send -- "exit\n"
