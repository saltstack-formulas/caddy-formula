# frozen_string_literal: true

control 'caddy.package.install' do
  title 'The required package should be installed'

  package_name = 'caddy'

  describe package(package_name) do
    it { should be_installed }
  end
end
