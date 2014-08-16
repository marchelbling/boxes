# timezone-ii default settings
default.tz = "Europe/Paris"

# default ntp settings
default.ntp.sync_clock = true

# openssh config
default.openssh.server.password_authentication = "no"
default.openssh.server.authorized_keys_file = '%h/.ssh/authorized_keys %h/.ssh/authorized_keys2'
