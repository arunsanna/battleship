# Utilize the image from download.yaml
# This is because we need to download the latest image from Red Hat. Current
# implementation for doing ARG based FROM instructions require replacing
# the FROM with an already existing image (i.e. one we've previously built).
# This prevents us from retrieving the latest image from Red Hat.
FROM registry.access.redhat.com/ubi8:8.5

COPY scripts /dsop-fix/

#COPY certs/Certificates_PKCS7_v5.7_DoD.pem /etc/pki/ca-trust/source/anchors/Certificates_PKCS7_v5.7_DoD.pem
#COPY yum.repo /etc/yum.repos.d/yum.repo

#COPY banner/issue /etc/

# Be careful when adding packages because this will ultimately be built on a licensed RHEL host,
# which enables full RHEL repositories and could allow for installation of packages that would
# violate Red Hat license agreement when running the container on a non-RHEL licensed host.
# See the following link for more details:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/building_running_and_managing_containers/index/#add_software_to_a_running_ubi_container

RUN echo Update packages and install DISA STIG fixes
# Disable all repositories (to limit RHEL host repositories) and only use official UBI repositories
# sed -i "s/enabled=1/enabled=0/" /etc/dnf/plugins/subscription-manager.conf && \
# exclude upating the 'filesystem' package due to errors with rootless builds
# https://github.com/containers/buildah/issues/3309
# exclude subscription-manager updates due to missing cloud-what dep in UBI repo

RUN echo "exclude=filesystem-*" >> /etc/dnf/dnf.conf

# To use private satelite
#chmod 644 /etc/issue /etc/yum.repos.d/yum.repo \
#/etc/pki/ca-trust/source/anchors/Certificates_PKCS7_v5.7_DoD.pem && \
#rm -f /etc/yum.repos.d/ubi.repo && \

RUN dnf repolist
RUN dnf update -y

# install missing dependency for libpwquality
RUN dnf install -y cracklib-dicts nss
RUN echo "* hard maxlogins 10" > /etc/security/limits.d/maxlogins.conf

# Do not use loops to iterate through shell scripts, this allows for scripts to fail
# but the build to still be successful. Be explicit when executing scripts and ensure
# that all scripts have "set -e" at the top of the bash file!
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_logon_fail_delay.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_max_concurrent_login_sessions.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_maximum_age_login_defs.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_minimum_age_login_defs.sh

# no remediation script, no accounts have passwords
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_all_shadowed_sha512.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_minlen_login_defs.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_dcredit.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_difok.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_lcredit.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_maxclassrepeat.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_maxrepeat.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_minclass.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_minlen.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_ocredit.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_pwhistory_remember_password_auth.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_pwhistory_remember_system_auth.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_ucredit.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_password_pam_unix_remember.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny_root.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_interval.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_unlock_time.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_bashrc.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_csh_cshrc.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_login_defs.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_profile.sh

#/dsop-fix/xccdf_org.ssgproject.content_rule_banner_etc_issue.sh && \
# rollback crypto policy to DEFAULT
#/dsop-fix/xccdf_org.ssgproject.content_rule_configure_crypto_policy.sh && \

RUN /dsop-fix/xccdf_org.ssgproject.content_rule_configure_kerberos_crypto_policy.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_configure_openssl_crypto_policy.sh

# usbguard not available in ubi
#/dsop-fix/xccdf_org.ssgproject.content_rule_configure_usbguard_auditbackend.sh && \
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_coredump_disable_backtraces.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_coredump_disable_storage.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_disable_ctrlaltdel_burstaction.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_disable_users_coredumps.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_display_login_attempts.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_ensure_gpgcheck_local_packages.sh

# /var/log/messages not used
# /dsop-fix/xccdf_org.ssgproject.content_rule_file_groupowner_var_log_messages.sh && \
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_file_groupownership_system_commands_dirs.sh

# /var/log/messages not used
# /dsop-fix/xccdf_org.ssgproject.content_rule_file_owner_var_log_messages.sh && \
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_network_configure_name_resolution.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_no_empty_passwords.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_openssl_use_strong_entropy.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_package_crypto-policies_installed.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_package_iptables_installed.sh

# rng-tools not available in ubi
# /dsop-fix/xccdf_org.ssgproject.content_rule_package_rng-tools_installed.sh && \
# sudo not required by default in container
# /dsop-fix/xccdf_org.ssgproject.content_rule_package_sudo_installed.sh && \
# usbguard not available in ubi
# /dsop-fix/xccdf_org.ssgproject.content_rule_package_usbguard_installed.sh && \
# sudo not required by default in container
# /dsop-fix/xccdf_org.ssgproject.content_rule_sudo_require_reauthentication.sh && \
# /dsop-fix/xccdf_org.ssgproject.content_rule_sudoers_validate_passwd.sh && \

RUN update-ca-trust
RUN update-ca-trust force-enable
RUN grep -c "BEGIN CERTIFICATE" /etc/pki/tls/certs/ca-bundle.crt
RUN trust list | head
RUN dnf clean all
RUN rm -rf /dsop-fix/ /var/cache/dnf/ /var/tmp/* /tmp/* /var/tmp/.???* /tmp/.???*

ENV container oci
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/bin/bash"]
