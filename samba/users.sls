{% if grains['os_family']=='RedHat' %}
include:
  - samba.client
{% endif %}

{% for login,smb_user in pillar.get('samba_users', {}).items() %}
{{ login }}:
  user.present:
    - fullname: {{ login }}
    - password: {{ smb_user.password }}

smbpasswd-{{ login }}:
  cmd.run:
    - name: '(echo {{ smb_user.password }}; echo {{ smb_user.password }}) | smbpasswd -as {{ login }}'
{% endfor %}
