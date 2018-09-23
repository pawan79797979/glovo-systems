output "ELB" {
	value = "${aws_elb.my-elb.dns_name}"
}

output "DOMAIN_NAME" {
        value = "${aws_cloudfront_distribution.elb_distribution.domain_name}"
}
