resource "aws_instance" "testEC2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "testEC2"
  }
}

resource "aws_ebs_volume" "testEBS" {
  availability_zone = aws_instance.testEC2.availability_zone
  size             = var.ebs_size

  tags = {
    Name = "testEBS"
  }
}

resource "aws_volume_attachment" "testAttachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.testEBS.id
  instance_id = aws_instance.testEC2.id
}
