
package model;

public class Payment {
    private int payment_id;
    private String payment_number;

    public Payment() {
    }

    public Payment(int payment_id, String payment_number) {
        this.payment_id = payment_id;
        this.payment_number = payment_number;
    }

    public int getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    public String getPayment_number() {
        return payment_number;
    }

    public void setPayment_number(String payment_number) {
        this.payment_number = payment_number;
    }

    @Override
    public int hashCode() {
        int hash = 3;
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
        final Payment other = (Payment) obj;
        return this.payment_id == other.payment_id;
    }
    
    
}
