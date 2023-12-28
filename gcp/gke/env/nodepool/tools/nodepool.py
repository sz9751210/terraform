import os
import re
from jinja2 import Environment, FileSystemLoader
path = os.getcwd()
match_list = []

def render_template(template_file, context):
    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template(template_file)
    return template.render(context)

for file in os.listdir(path):
    if file.endswith(".tf"):
        with open(file, "r") as f:
            content = f.read()
            module_name_match = re.search(r'resource "google_container_node_pool" "(.+?)"', content)
            if module_name_match:
                module_name = module_name_match.group(1)
                max_node_count_match      = re.search(r'max_node_count = (.+?)', content)
                min_node_count_match      = re.search(r'min_node_count = (.+?)', content)
                cluster_match             = re.search(r'cluster            = "(.+?)"', content)
                initial_node_count_match  = re.search(r'initial_node_count = (.+?)', content)
                location_match            = re.search(r'location           = "(.+?)"', content)
                max_pods_per_node_match   = re.search(r'max_pods_per_node = (\d+)', content)
                name_match                = re.search(r'name              = "(.+?)"', content)
                pod_ipv4_cidr_block_match = re.search(r'pod_ipv4_cidr_block = "(.+?)"', content)
                labels_match              = re.search(r'labels\s*=\s*{([^}]*)}', content, re.MULTILINE)
                disk_size_gb_match        = re.search(r'disk_size_gb = (\d+)', content)
                machine_type_match        = re.search(r'machine_type = "(.+?)"', content)
                node_count_match          = re.search(r'node_count     = (.+?)', content)
                project_match             = re.search(r'project        = "(.+?)"', content)
                max_surge_match           = re.search(r'max_surge       = (.+?)', content)
                max_unavailable_match     = re.search(r'max_unavailable = (.+?)', content)
                node_version_match        = re.search(r'version = "(.+?)"', content)
                if max_node_count_match and min_node_count_match and cluster_match and initial_node_count_match and location_match and max_pods_per_node_match and name_match and pod_ipv4_cidr_block_match and labels_match and disk_size_gb_match and machine_type_match and node_count_match and project_match and max_surge_match and max_unavailable_match and node_version_match:
                    match_list.append({"module_name":module_name,
                                       "max_node_count":max_node_count_match.group(1),
                                       "min_node_count":min_node_count_match.group(1),
                                       "cluster":cluster_match.group(1),
                                       "initial_node_count":initial_node_count_match.group(1),
                                       "location":location_match.group(1),
                                       "max_pods_per_node":max_pods_per_node_match.group(1),
                                       "name":name_match.group(1),
                                       "pod_ipv4_cidr_block":pod_ipv4_cidr_block_match.group(1),
                                       "labels":labels_match.group(1) if labels_match else 0,
                                       "disk_size_gb":disk_size_gb_match.group(1),
                                       "machine_type":machine_type_match.group(1),
                                       "node_count":node_count_match.group(1),
                                       "project":project_match.group(1),
                                       "max_surge":max_surge_match.group(1),
                                       "max_unavailable":max_unavailable_match.group(1),
                                       "node_version":node_version_match.group(1),
                                      })

for item in match_list:
    template_file = "template.tf.jinja"
    rendered_template = render_template(template_file, item)
    with open("module/{}.tf".format(item["name"]), "w") as f:
        f.write(rendered_template)
