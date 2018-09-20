ource "aws_launch_configuration" "glovo-launchconfig" {
  name_prefix          = "glovo-launchconfig"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  security_groups      = ["${aws_security_group.myinstance.id}"]
  user_data            = "${file("userdata.sh")}"
  lifecycle              { create_before_destroy = true }
  }

resource "aws_autoscaling_group" "glovo-autoscaling" {
  name                 = "glovo-autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
  launch_configuration = "${aws_launch_configuration.glovo-launchconfig.name}"
  min_size             = 2
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  load_balancers = ["${aws_elb.my-elb.name}"]
  force_delete = true

  tag {
      key = "Name"
      value = "ec2 instance"
      propagate_at_launch = true
  }
}
