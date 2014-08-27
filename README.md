# Serf Cookbook

Installs the Serf software package and allows joining cluster via LWRP.

# Requirements

## Platforms

 * Debian

## Cookbooks

 * partial_search

# Attribtues

 * See Attributes file for details

# Recipes

 * default

# Usage

This cookbook comes with sane defaults and some role based changes for
Kitchen to allow convergence of nodes. With all defaults applied, you
can proceed like this to create a serf cluster:

 * Create the serf/cluster data bag (see below)
 * Attach this cookbook to a `serf-cluster` role
 * Assign `serf-cluster` role to all nodes that require Serf
 * Add `serf-cluster-node` tag to all nodes that should join
 * Run `chef-client` on all nodes

# Data Bag

We require a encrypted data bag with the `encrypt_key` key set (16 byte
string):

```
{
  "id": "cluster-01",
  "encrypt_key": "z/XKT1lOkg1guTtqEfhVww=="
}
```

# Testing

The cookbook provides the following Rake tasks for testing:

    rake foodcritic                   # Lint Chef cookbooks
    rake knife                        # Knife cookbook tests
    rake integration                  # Alias for kitchen:all
    rake kitchen:all                  # Run all test instances
    rake kitchen:default-debian-74    # Run default-debian-74 test instance, works for all `kitchen list` instances
    rake rubocop                      # Run RuboCop style and lint checks
    rake chefspec                     # Run ChefSpec examples
    rake test                         # Run all tests

# License and Author

Author:: Sebastian Grewe (sebgrewe@bigpoint.com)

Copyright:: 2014, Sebastian Grewe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Contributing

We welcome contributed improvements and bug fixes via the usual
workflow:

1. Fork this repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
