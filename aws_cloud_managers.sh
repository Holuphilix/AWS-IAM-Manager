#!/usr/bin/bash

# IAM Users Array
iam_users=("Alice" "Bob" "Charlie" "Diana" "Eve")

# Function to create IAM users
create_iam_users() {
  echo "Creating IAM Users..."
  for user in "${iam_users[@]}"; do
    echo "Creating user: $user"
    aws iam create-user --user-name "$user" 2>/dev/null || echo "User $user already exists or failed to create."
  done
}

# Function to create IAM group
create_iam_group() {
  group_name="admin"
  echo "Creating IAM group: $group_name"
  aws iam create-group --group-name "$group_name" 2>/dev/null || echo "Group $group_name already exists or failed to create."
}

# Function to attach AdministratorAccess policy to group
attach_admin_policy() {
  group_name="admin"
  policy_arn="arn:aws:iam::aws:policy/AdministratorAccess"
  echo "Attaching AdministratorAccess policy to group: $group_name"
  aws iam attach-group-policy --group-name "$group_name" --policy-arn "$policy_arn"
}

# Function to assign users to group
assign_users_to_group() {
  group_name="admin"
  echo "Adding IAM users to group: $group_name"
  for user in "${iam_users[@]}"; do
    echo "Adding user: $user to group: $group_name"
    aws iam add-user-to-group --user-name "$user" --group-name "$group_name" 2>/dev/null || echo "Failed to add user $user to group $group_name."
  done
}

# Call the functions
create_iam_users
create_iam_group
attach_admin_policy
assign_users_to_group


