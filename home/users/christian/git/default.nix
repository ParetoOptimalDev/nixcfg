{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.git;

in

{
  options = {
    custom.users.christian.git = {
      enable = mkEnableOption "Git";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.lazygit.enable = true;

    programs.git = {
      enable = true;
      userName = "Christian Harke";
      signing.key = "630966F4";

      aliases = {
        co = "checkout";
        cp = "cherry-pick";
        changes = "diff --name-status -r";
        d = "diff";
        dh = "diff HEAD";
        ds = "diff --staged";
        dw = "diff --color-words";
        fu = "commit -a --fixup=HEAD";
        ignored = "ls-files --exclude-standard --ignored --others";
        lg = "log --graph --full-history --all --color --pretty=format:'%x1b[33m%h%x09%C(blue)(%ar)%C(reset)%x09%x1b[32m%d%x1b[0m%x20%s%x20%C(dim white)-%x20%G?%x20%an%C(reset)'";
        rc = "rebase --continue";
        ri = "rebase --interactive --autosquash";
        rs = "rebase --skip";
        s = "status";
        ss = "status -s";
      };

      ignores = [
        ###
        # OS X
        ###

        # General
        ".DS_Store.AppleDouble.LSOverride"

        # Icon must end with two \r
        "Icon"

        # Thumbnails
        "._*"

        # Files that might appear in the root of a volume
        ".DocumentRevisions-V100"
        ".fseventsd"
        ".Spotlight-V100"
        ".TemporaryItems"
        ".Trashes"
        ".VolumeIcon.icns"
        ".com.apple.timemachine.donotpresent"

        # Directories potentially created on remote AFP share
        ".AppleDB"
        ".AppleDesktop"
        "Network Trash Folder"
        "Temporary Items"
        ".apdisk"

        ###
        # Java
        ###

        # Compiled class file
        "*.class"

        # Log file
        "*.log"

        # Mobile Tools for Java (J2ME)
        ".mtj.tmp/"

        # Package Files #
        "*.jar"
        "*.war"
        "*.nar"
        "*.ear"
        "*.rar"

        # virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
        "hs_err_pid"

        # IDEs
        ".idea/"
        ".vscode/"

        ##
        # Node
        ##

        # Logs
        "logs"
        "*.log"
        "npm-debug.log*"
        "yarn-debug.log*"
        "yarn-error.log*"
        "lerna-debug.log*"

        # Diagnostic reports (https://nodejs.org/api/report.html)
        "report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json"

        # Runtime data
        "pids"
        "*.pid"
        "*.seed"
        "*.pid.lock"

        # Directory for instrumented libs generated by jscoverage/JSCover
        "lib-cov"

        # Coverage directory used by tools like istanbul
        "coverage"
        "*.lcov"

        # nyc test coverage
        ".nyc_output"

        # Grunt intermediate storage (https://gruntjs.com/creating-plugins#storing-task-files)
        ".grunt"

        # Bower dependency directory (https://bower.io/)
        "bower_components"

        # node-waf configuration
        ".lock-wscript"

        # Compiled binary addons (https://nodejs.org/api/addons.html)
        "build/Release"

        # Dependency directories
        "node_modules/"
        "jspm_packages/"

        # TypeScript v1 declaration files
        "typings/"

        # TypeScript cache
        "*.tsbuildinfo"

        # Optional npm cache directory
        ".npm"

        # Optional eslint cache
        ".eslintcache"

        # Optional REPL history
        ".node_repl_history"

        # Output of 'npm pack'
        "*.tgz"

        # Yarn Integrity file
        ".yarn-integrity"

        # dotenv environment variables file
        ".env"
        ".env.test"

        # parcel-bundler cache (https://parceljs.org/)
        ".cache"

        # next.js build output
        ".next"

        # nuxt.js build output
        ".nuxt"

        # vuepress build output
        ".vuepress/dist"

        # Serverless directories
        ".serverless/"

        # FuseBox cache
        ".fusebox/"

        # DynamoDB Local files
        ".dynamodb/"

        # VIM swap files
        "*.swp"
      ];
    };
  };
}
