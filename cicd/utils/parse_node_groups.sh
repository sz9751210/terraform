#!/bin/bash

# Function to parse node groups
parse_node_groups() {
    local yaml_file=$1
    local node_groups_str=""
    local index=0

    while true; do
        local node_group=$(yq e ".EKS.NODE_GROUPS[$index]" "$yaml_file")
        if [ "$node_group" != "null" ]; then
            local node_group_name=$(yq e ".EKS.NODE_GROUPS[$index].node_group_name" "$yaml_file")
            local instance_types_str=$(yq e ".EKS.NODE_GROUPS[$index].instance_types[]" "$yaml_file" | awk '{printf "\"%s\", ", $0}' | sed 's/, $//')
            local node_desired_size=$(yq e ".EKS.NODE_GROUPS[$index].node_desired_size" "$yaml_file")
            local node_max_size=$(yq e ".EKS.NODE_GROUPS[$index].node_max_size" "$yaml_file")
            local node_min_size=$(yq e ".EKS.NODE_GROUPS[$index].node_min_size" "$yaml_file")

            if [ ! -z "$node_group_name" ] && [ ! -z "$instance_types_str" ]; then
                node_groups_str+=$(cat <<EOF
    {
      node_group_name   = "$node_group_name"
      instance_types    = [$instance_types_str]
      node_desired_size = $node_desired_size
      node_max_size     = $node_max_size
      node_min_size     = $node_min_size
    },
EOF
)
            fi

            ((index++))
        else
            break
        fi
    done

    echo "$node_groups_str"
}
