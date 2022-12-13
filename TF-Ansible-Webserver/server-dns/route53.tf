# Route 53 Resources
resource "aws_route53_zone" "website_domain_name" {
  name = "${var.website_domain_name}"
  tags = {
    Name = "${var.prefix}-${var.aws-profile}-website-domain"
  }
}

resource "aws_route53_record" "a_record_item" {
  zone_id = "${aws_route53_zone.website_domain_name.zone_id}"
  name    = "${element(split(" ", var.aRecords[count.index]),0)}"
  type    = "A"
  ttl     = "${var.ttl}"
  records = ["${element(split(" ", var.aRecords[count.index]),1)}"]
  count   = "${length(var.cnameRecords)}"
}

resource "aws_route53_record" "cname_record_item" {
  zone_id = "${aws_route53_zone.website_domain_name.zone_id}"
  name    = "${element(split(" ", var.cnameRecords[count.index]),0)}"
  type    = "CNAME"
  ttl     = "${var.ttl}"
  records = ["${element(split(" ", var.cnameRecords[count.index]),1)}"]
  count   = "${length(var.cnameRecords)}"
}