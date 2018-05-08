job "replicator" {
  datacenters = ["dc1"]
  region      = "global"
  type        = "service"

  update {
    stagger      = "10s"
    max_parallel = 1
  }

  meta {
    VERSION = "v1.0.3"
  }

  constraint {
    distinct_hosts = true
  }

  group "replicator" {
    count = 2

    task "replicator" {
      driver = "exec"

      constraint {
        attribute = "${attr.kernel.name}"
        value     = "linux"
      }

      config {
        command = "${attr.kernel.name}-${attr.cpu.arch}-replicator"
        args    = [
          "agent",
        ]
      }

      artifact {
        source = "https://github.com/glympse/replicator/releases/download/${NOMAD_META_VERSION}/${attr.kernel.name}-${attr.cpu.arch}-replicator"
      }

      resources {
        cpu    = 250
        memory = 60

        network {
          mbits = 5
        }
      }
    }
  }
}
