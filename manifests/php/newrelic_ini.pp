# This module should not be used directly. It is used by newrelic::php.
define newrelic::php::newrelic_ini (
  $newrelic_license_key,
  $exec_path,
) {

  $newrelic_ini_appname = $::newrelic::agent::php::newrelic_ini_appname
  $newrelic_ini_browser_monitoring_auto_instrument = $::newrelic::agent::php::newrelic_ini_browser_monitoring_auto_instrument
  $newrelic_ini_enabled = $::newrelic::agent::php::newrelic_ini_enabled
  $newrelic_ini_error_collector_enabled = $::newrelic::agent::php::newrelic_ini_error_collector_enabled
  $newrelic_ini_error_collector_prioritize_api_errors = $::newrelic::agent::php::newrelic_ini_error_collector_prioritize_api_errors
  $newrelic_ini_error_collector_record_database_errors = $::newrelic::agent::php::newrelic_ini_error_collector_record_database_errors
  $newrelic_ini_framework = $::newrelic::agent::php::newrelic_ini_framework
  $newrelic_ini_high_security = $::newrelic::agent::php::newrelic_ini_high_security
  $newrelic_ini_logfile = $::newrelic::agent::php::newrelic_ini_logfile
  $newrelic_ini_loglevel = $::newrelic::agent::php::newrelic_ini_loglevel
  $newrelic_ini_transaction_tracer_custom = $::newrelic::agent::php::newrelic_ini_transaction_tracer_custom
  $newrelic_ini_transaction_tracer_detail = $::newrelic::agent::php::newrelic_ini_transaction_tracer_detail
  $newrelic_ini_transaction_tracer_enabled = $::newrelic::agent::php::newrelic_ini_transaction_tracer_enabled
  $newrelic_ini_transaction_tracer_explain_enabled = $::newrelic::agent::php::newrelic_ini_transaction_tracer_explain_enabled
  $newrelic_ini_transaction_tracer_explain_threshold = $::newrelic::agent::php::newrelic_ini_transaction_tracer_explain_threshold
  $newrelic_ini_transaction_tracer_record_sql = $::newrelic::agent::php::newrelic_ini_transaction_tracer_record_sql
  $newrelic_ini_transaction_tracer_slow_sql = $::newrelic::agent::php::newrelic_ini_transaction_tracer_slow_sql
  $newrelic_ini_transaction_tracer_stack_trace_threshold = $::newrelic::agent::php::newrelic_ini_transaction_tracer_stack_trace_threshold
  $newrelic_ini_transaction_tracer_threshold = $::newrelic::agent::php::newrelic_ini_transaction_tracer_threshold
  $newrelic_ini_capture_params = $::newrelic::agent::php::newrelic_ini_capture_params
  $newrelic_ini_ignored_params = $::newrelic::agent::php::newrelic_ini_ignored_params
  $newrelic_ini_webtransaction_name_files = $::newrelic::agent::php::newrelic_ini_webtransaction_name_files













  exec { "/usr/bin/newrelic-install ${name}":
    path     => $exec_path,
    command  => "/usr/bin/newrelic-install purge ; NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${newrelic_license_key}
       /usr/bin/newrelic-install install",
    provider => 'shell',
    user     => 'root',
    group    => 'root',
    unless   => "grep ${newrelic_license_key} ${name}/newrelic.ini",
  }

  file { "${name}/newrelic.ini":
    path    => "${name}/newrelic.ini",
    content => template('newrelic/newrelic.ini.erb'),
    require => Exec["/usr/bin/newrelic-install ${name}"],
  }

}
