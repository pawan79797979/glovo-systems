locals {
        ELB_DNS = "${aws_elb.my-elb.dns_name}"
}
