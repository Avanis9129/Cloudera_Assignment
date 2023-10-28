module "s3_bucket" {
source = "./s3"
}

module "roles" {
source = "./roles"

}