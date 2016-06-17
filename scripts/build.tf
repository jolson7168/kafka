
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_security_group" "zookeeper" {
  name = "zookeeper-sg"
  description = "Zookeeper Security Group"
  vpc_id = "${var.aws_vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ZooKeeper Node"
  }
}


resource "template_file" "salt_bootstrap_zookeeper" {
    count    = "${var.zookeeper_count}"
    template = "${file("salt_bootstrap_zookeeper.tpl")}"

    vars {
        hostname = "${lookup(var.zookeeper_hostnames, count.index)}"
        local_ip = "${lookup(var.zookeeper_ips, count.index)}"
    }
}

resource "aws_instance" "zookeeper" {

    count = "${var.zookeeper_count}" 
    ami = "${var.aws_centos_ami}"
    instance_type = "t2.small"
    subnet_id = "${var.aws_subnet_id}"
    vpc_security_group_ids = ["${aws_security_group.zookeeper.id}"]
    associate_public_ip_address = false
    private_ip = "${lookup(var.zookeeper_ips, count.index)}"
    availability_zone = "${var.aws_availability_zone}"
    instance_initiated_shutdown_behavior = "stop"
    user_data = "${element(template_file.salt_bootstrap_zookeeper.*.rendered, count.index)}"
    key_name = "${var.zookeeper_rsa}"
    tags {
        Name = "kafkaTest"
    } 
    root_block_device {  
        volume_size = 20
        volume_type = "gp2"
        delete_on_termination = true
    }
    ebs_block_device {
        device_name = "/dev/xvdb"     
        volume_size = 200
        volume_type = "standard"
        delete_on_termination = true
  }

}
