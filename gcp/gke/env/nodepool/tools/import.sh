node_pools_name=($(ls | awk -F ".tf" '{print $1}'))
for node_pool_name in "${node_pools_name[@]}"
do
    # echo -e "terraform.$filename"
    module_name=$(echo $node_pool_name | sed 's/-/_/g')
    terraform import module.$module_name.google_container_node_pool.node_pool project_id/asia-east1-b/cluster_name/$node_pool_name
done
