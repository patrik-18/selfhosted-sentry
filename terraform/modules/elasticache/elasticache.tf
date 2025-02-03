resource "aws_elasticache_subnet_group" "sentry_redis_subnet" {
  name       = "sentry-redis-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "sentry_redis" {
  cluster_id           = "sentry-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  subnet_group_name    = aws_elasticache_subnet_group.sentry_redis_subnet.name
  security_group_ids   = [var.security_group]
}

output "redis_endpoint" {
  description = "Redis primary endpoint"
  value       = aws_elasticache_cluster.sentry_redis.cache_nodes[0].address
}
