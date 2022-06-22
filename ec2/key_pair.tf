# resource "aws_key_pair" "wearslot" {

#   key_name = "wearslot"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdt9wgVvKQkquNBYRZS15fde+09HpFd3PxwgxBm/MgSBJ8Qv3ou82dg9fPmbJ/PSjvwy9Ut9Q8w31NsWPiD/tIWqRFz7eaJuRwNr3MZzSxvLtb+hZP/oQdb7cu/TQFZV16C/xE3NiiX7VI+Az255gGUMVVR3z22jYEVBzUzRz0BnZ3ntlkfHt2ecWxfALj4YPCaGdLXe21gAELo/va/YW+whNXbUpViRi99hbjYLTdquT3H52oL2mgi0+VOMvQMF3W/b6Zjxh16MwVSkV31ZYxiRUvFJpUeI7duXu94U8hRP88L3oiPXssonqX2cNDPaLz/gW2teE2FKvLYLCR1JqWhrfzKGqINxt6wqvH8ln/J3tgTEU2qrzjgZ/ZUlPlN8vXOv5rtYtk8+OlIE/0+IbjNtT/Cgk+Hh9LTb06hMowhSBC9v6Jlngf/SOFkiIUBhFviEysAgRZlX3xLg3FF6rQM9n/ssAlRfZ5B862AdFcAQhNQiyRB5WUid4obh1h7W0= devops@wearslot.com"
# }

// Generate the SSH keypair that we’ll use to configure the EC2 instance.
// After that, write the private key to a local file and upload the public key to AWS
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "foo" {
  content         = tls_private_key.key.private_key_pem
  filename        = "wearslot.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "wearslot"
  public_key = tls_private_key.key.public_key_openssh
}
