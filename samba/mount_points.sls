mount_root:
  file.directory:
    - name: {{ pillar['mount_root'] }}
    - user: root
    - group: root
    - makedirs: true

{% for mount_point in salt['pillar.get']('mount_points', {}) %}
add_mount_point-{{ mount_point }}:
  file.directory:
    - name: {{ pillar['mount_root'] }}/{{ mount_point }}
    - user: root
    - group: {{ pillar['mount_points'][mount_point] }}
    - dir_mode: 2770
    - require:
      - mount_root
 {% endfor %}    
