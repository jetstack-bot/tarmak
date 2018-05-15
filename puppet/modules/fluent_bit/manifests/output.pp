define fluent_bit::output (
  Hash $config = {},
){
  include ::fluent_bit

  $path = $::fluent_bit::path

  $types = $config['types']

  if $config['elasticsearch'] {

    $elasticsearch = $config['elasticsearch']

    if $elasticsearch['awsESProxy'] {

      ::aws_es_proxy::instance{ $name:
        tls          => $elasticsearch['tls'],
        dest_port    => $elasticsearch['port'],
        dest_address => $elasticsearch['host'],
        listen_port  => $elasticsearch['awsESProxy']['port'],
      }

    }

  }

  file { "/etc/td-agent-bit/td-agent-bit-output-${name}.conf":
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('fluent_bit/td-agent-bit-output.conf.erb'),
  }

  file { "/etc/td-agent-bit/daemonset/td-agent-bit-output-${name}.conf":
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('fluent_bit/td-agent-bit-output.conf.erb'),
  }

}
