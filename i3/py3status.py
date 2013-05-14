class Py3status:
    def empty(self, json, i3status_config):
        response = { 'full_text' : '', 'name' : 'empty' }
        return (0, response)
