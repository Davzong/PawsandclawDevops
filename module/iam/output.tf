output "aws_iam_role_ecs_auto_scale_role" {
    value = aws_iam_role.ecs_auto_scale_role
}

output "aws_iam_role_policy_attachment_ecs_task_execution_role_policy_attachment" {
    value = aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment
}

output "aws_iam_role_ecs_task_execution_role" {
    value = aws_iam_role.ecs_task_execution_role
}