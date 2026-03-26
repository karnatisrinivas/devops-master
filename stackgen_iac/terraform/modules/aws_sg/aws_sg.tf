resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = var.tags
}


resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each          = { for u in var.ingress : u.description => u }
  security_group_id = aws_security_group.this.id
  description       = each.key
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}
resource "aws_vpc_security_group_egress_rule" "this" {
  for_each          = { for u in var.egress : u.description => u }
  security_group_id = aws_security_group.this.id
  description       = each.key
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}



