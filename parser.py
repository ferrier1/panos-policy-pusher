from terraform_external_data import terraform_external_data
import csv, re
from itertools import chain

@terraform_external_data
def parse_csv(query):
    with open('example.csv', newline='', encoding='utf-8-sig') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        ruleset = [rules for rules in reader]
        if len(ruleset) > 1:
            sorted = list(zip(*chain(list(ruleset))))
        else:
            sorted = list(*chain(list(ruleset)))
        l = []
        for x in sorted:
            t = re.sub(r'[/(|)|\'|" "/]', '', str(x))
            l.append(t)
        return {
                query['names']: str(l[0]),
                query['source_zones']: str(l[1]),
                query['source_addresses']: str(l[2]),
                query['source_users']: str(l[3]),
                query['hip_profiles']: str(l[4]),
                query['destination_zones']: str(l[5]),
                query['destination_addresses']: str(l[6]),
                query['applications']: str(l[7]),
                query['services']: str(l[8]),
                query['categories']: str(l[9]),
                query['action']: str(l[10])
                }

if __name__ == '__main__':
    parse_csv()
