
package model;

public class Rule {
    private int rule_id;
    private String rule_name;

    public Rule() {
    }

    public Rule(int rule_id, String rule_name) {
        this.rule_id = rule_id;
        this.rule_name = rule_name;
    }

    
    public int getRule_id() {
        return rule_id;
    }

    public void setRule_id(int rule_id) {
        this.rule_id = rule_id;
    }

    public String getRule_name() {
        return rule_name;
    }

    public void setRule_name(String rule_name) {
        this.rule_name = rule_name;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Rule other = (Rule) obj;
        return this.rule_id == other.rule_id;
    }
    
    
}
