resource "docker_image" "custom_image" {
  name = "my_custom_image:latest"

  build {
    context    = "${path.module}/path/to/dockerfile-directory"
    dockerfile = "Dockerfile"
  }
}
