{ config, ... }:

{
  sops.secrets."api/hyrulelabs_cf_dns" = { };

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@hyrulelabs.com";

    certs."hyrulelabs.com" = {
      domain = "pihole.hyrulelabs.com";
      group = "nginx";
      extraDomainNames = [
        "mk.hyrulelabs.com"
        "plex.hyrulelabs.com"
      ];
      dnsProvider = "cloudflare";
      credentialFiles = {
        CLOUDFLARE_DNS_API_TOKEN_FILE = config.sops.secrets."api/hyrulelabs_cf_dns".path;
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    proxyResolveWhileRunning = true;
    resolver = {
      addresses = [ "100.100.100.100" ];
      valid = "30s";
    };

    virtualHosts = {
      "pihole.hyrulelabs.com" = {
        forceSSL = true;
        useACMEHost = "hyrulelabs.com";
        locations."/".proxyPass = "http://desert.tail8c5bfe.ts.net:82";
      };

      "mk.hyrulelabs.com" = {
        forceSSL = true;
        useACMEHost = "hyrulelabs.com";
        locations."/".proxyPass = "http://desert.tail8c5bfe.ts.net:3000";
      };

      "plex.hyrulelabs.com" = {
        forceSSL = true;
        useACMEHost = "hyrulelabs.com";
        locations."/" = {
          proxyPass = "http://127.0.0.1:32400";
          proxyWebsockets = true;
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
