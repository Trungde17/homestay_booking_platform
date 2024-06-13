package model;

public class Neighbourhood {
    private int neighbourhood_id;
    private String neighbourhood_name;

    public Neighbourhood() {
    }

    public Neighbourhood(int neighbourhood_id, String neighbourhood_name) {
        this.neighbourhood_id = neighbourhood_id;
        this.neighbourhood_name = neighbourhood_name;
    }
    
    public int getNeighbourhood_id() {
        return neighbourhood_id;
    }

    public void setNeighbourhood_id(int neighbourhood_id) {
        this.neighbourhood_id = neighbourhood_id;
    }

    public String getNeighbourhood_name() {
        return neighbourhood_name;
    }

    public void setNeighbourhood_name(String neighbourhood_name) {
        this.neighbourhood_name = neighbourhood_name;
    }

    @Override
    public int hashCode() {
        int hash = 5;
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
        final Neighbourhood other = (Neighbourhood) obj;
        return this.neighbourhood_id == other.neighbourhood_id;
    }
    
    
}
