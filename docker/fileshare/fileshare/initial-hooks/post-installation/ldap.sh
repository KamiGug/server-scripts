#!/bin/sh
## https://docs.nextcloud.com/server/latest/admin_manual/occ_command.html
## sudo -u www-data
# su --command '/path/to/php ...' username
# su --command '
echo im in >/tmp/asdf
sudo -u www-data php /var/www/html/occ app:install user_ldap
sudo -u www-data php /var/www/html/occ app:enable user_ldap
sudo -u www-data php /var/www/html/occ ldap:create-empty-config

sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapHost "ldap://ldap"
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapPort 3890
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapAgentName "uid=admin,ou=people,$LDAP_DOMAIN" #dc=test,dc=ananas-project,dc=dns-dynamic,dc=net
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapAgentPassword "$LDAP_PASS"

sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapBase "$LDAP_DOMAIN"
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapBaseUsers "$LDAP_DOMAIN"
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapBaseGroups "$LDAP_DOMAIN"
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapConfigurationActive 1
sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapLoginFilter "(&(objectclass=person)(uid=%uid))"

# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUserFilter "(&(objectclass=person)(memberOf=cn=nextcloud_users,ou=groups,$LDAP_DOMAIN))";
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUserFilterMode 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUserFilterObjectclass person;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 turnOnPasswordChange 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapCacheTTL 600;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapExperiencedAdmin 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGidNumber gidNumber;
#
#
#
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGroupFilter "(&(objectclass=groupOfUniqueNames)(|(cn=developers)(cn=testers)))";
#
#
#
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGroupFilterGroups "developers;testers";
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGroupFilterMode 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGroupDisplayName cn;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGroupFilterObjectclass groupOfUniqueNames;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapGroupMemberAssocAttr uniqueMember;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapEmailAttribute "mail" ;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapLoginFilterEmail 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapLoginFilterUsername 1;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapMatchingRuleInChainState unknown;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapNestedGroups 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapPagingSize 500;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapTLS 0;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUserAvatarRule default;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUserDisplayName displayname;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUserFilterMode 1;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUuidGroupAttribute auto;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapUuidUserAttribute auto;
# sudo -u www-data php /var/www/html/occ ldap:set-config s01 ldapExpertUsernameAttr user_id;
#  ' www-data
