{ config, ... }:

{
  sops.secrets = {
    "api/ai_chats/gemini_free" = { };
    "api/ai_chats/gemini_prepaid" = { };
    "jungle/librechat/creds-key" = { };
    "jungle/librechat/creds-iv" = { };
    "jungle/librechat/jwt-secret" = { };
    "jungle/librechat/jwt-refresh-secret" = { };
  };

  services.librechat = {
    enable = true;
    dataDir = "/persist/librechat";
    enableLocalDB = true;

    env = {
      ALLOW_REGISTRATION = false;
      GEMINI_IMAGE_MODEL = "gemini-3.1-flash-image";
      GOOGLE_MODELS = builtins.concatStringsSep "," [
        "gemini-3.6-flash"
        "gemini-3.5-flash"
        "gemini-3.5-flash-lite"
        "gemini-3.1-flash-lite"
        "gemini-3.1-pro-preview"
      ];
    };

    credentials = {
      CREDS_KEY = config.sops.secrets."jungle/librechat/creds-key".path;
      CREDS_IV = config.sops.secrets."jungle/librechat/creds-iv".path;
      JWT_SECRET = config.sops.secrets."jungle/librechat/jwt-secret".path;
      JWT_REFRESH_SECRET = config.sops.secrets."jungle/librechat/jwt-refresh-secret".path;
      GEMINI_FREE_KEY = config.sops.secrets."api/ai_chats/gemini_free".path;
      GEMINI_API_KEY = config.sops.secrets."api/ai_chats/gemini_prepaid".path;
      GOOGLE_KEY = config.sops.secrets."api/ai_chats/gemini_prepaid".path;
    };

    settings = {
      version = "1.2.1";
      cache = true;
      includedTools = [ "gemini_image_gen" ];
      endpoints.custom = [
        {
          name = "Gemini Free";
          apiKey = "\${GEMINI_FREE_KEY}";
          baseURL = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
          directEndpoint = true;
          models = {
            default = [
              "gemini-3.6-flash"
              "gemini-3.5-flash"
              "gemini-3.5-flash-lite"
              "gemini-3.1-flash-lite"
            ];
            fetch = false;
          };
          customParams.defaultParamsEndpoint = "google";
          titleConvo = true;
          titleModel = "gemini-3.5-flash-lite";
          modelDisplayLabel = "Gemini Free";
          iconURL = "google";
        }
      ];
    };
  };
}
