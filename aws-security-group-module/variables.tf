variable "rules" {
    default = [
        {
            port        = 80
            porto       = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        },
        {
            port        = 22
            porto       = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        }
    ]
}
