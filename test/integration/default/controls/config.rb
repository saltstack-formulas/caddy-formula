# frozen_string_literal: true

control 'caddy.config.file' do
  title 'Verify the configuration file'

  describe file('/etc/caddy/Caddyfile') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') do
      should include(
        'File managed by Salt at <salt://caddy/files/default/Caddyfile.tmpl.jinja>'
      )
    end
    # rubocop:disable Lint/RedundantCopDisableDirective
    # rubocop:disable Layout/LineLength
    its('content') do
      should match(
        "{\n"\
        "\temail webmaster@example.net\n"\
        "\tauto_https off\n"\
        "\tlog main {\n"\
        "\t\tlevel WARN\n"\
        "\t\toutput file /var/log/caddy/caddy-general.log\n"\
        "\t}\n"\
        '}'
      )
    end
    its('content') do
      should match(
        "localhost {\n"\
        "\troot \\* /usr/share/caddy\n"\
        "\tlog {\n"\
        "\t\tlevel WARN\n"\
        "\t\toutput file /var/log/caddy/localhost.log\n"\
        "\t}\n"\
        '}'
      )
    end
    its('content') do
      should match(
        "example.com:80 {\n"\
        "\tredir https://example.net\n"\
        '}'
      )
    end
    its('content') do
      should match(
        "example.net {\n"\
        "\tencode gzip\n"\
        "\thandle_path /\\* {\n"\
        "\t\troot \\* /var/www/example.net/\n"\
        "\t\tfile_server\n"\
        "\t}\n"\
        "\tlog {\n"\
        "\t\tlevel WARN\n"\
        "\t\toutput file /var/log/caddy/example.net.log\n"\
        "\t}\n"\
        '}'
      )
    end
    its('content') do
      should match(
        "multi.level.example.net {\n"\
        "\tencode gzip\n"\
        "\troute /path/\\* {\n"\
        "\t\tbasicauth \\* {\n"\
        "\t\t\tuser JDJhJDE0JFJxLjBBTXhVTHF2VHBoVU54LjFXQnVEQkZYdFhlVmUzSmxRL3VrQVcwS05IQnVIS2FBREIy\n"\
        "\t\t}\n"\
        "\t\troot \\* /var/www/html/\n"\
        "\t\ttry_files {path} /path/to/index.cgi\n"\
        "\t\t@cgi path \\*.cgi\n"\
        "\t\thandle /path/to/index.cgi {\n"\
        "\t\t\treverse_proxy @cgi unix//run/fcgiwrap.socket {\n"\
        "\t\t\t\ttransport fastcgi {\n"\
        "\t\t\t\t\tresolve_root_symlink\n"\
        "\t\t\t\t\tsplit .cgi\n"\
        "\t\t\t\t}\n"\
        "\t\t\t}\n"\
        "\t\t}\n"\
        "\t\tfile_server\n"\
        "\t}\n"\
        "\tlog {\n"\
        "\t\tlevel WARN\n"\
        "\t\toutput file /var/log/caddy/multi.level.example.net.log\n"\
        "\t}\n"\
        '}'
      )
    end
    # rubocop:enable Layout/LineLength
    # rubocop:enable Lint/RedundantCopDisableDirective
  end
end
