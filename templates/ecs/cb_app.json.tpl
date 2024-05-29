[
  {
    "name": "paws-and-claws-ecr",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/cb-app",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
     "secrets": [
        {
            "name": "MONGO_URL",
            "valueFrom": "arn:aws:ssm:ap-southeast-2:058264389558:parameter/MONGO_URI"
        },
        {
            "name": "JWT_EXPIRE",
            "valueFrom": "arn:aws:ssm:ap-southeast-2:058264389558:parameter/JWT_EXPIRE"
        },
        {
            "name": "JWT_SECRET",
            "valueFrom": "arn:aws:ssm:ap-southeast-2:058264389558:parameter/JWT_SECRET"
        },
        {
            "name": "NEXT_PUBLIC_SHOW_LOGGER",
            "valueFrom": "arn:aws:ssm:ap-southeast-2:058264389558:parameter/NEXT_PUBLIC_SHOW_LOGGER"
        }
    ]
  }
]