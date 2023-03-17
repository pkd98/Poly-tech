import java.util.Objects;

public class Pocket<T> { 
    private T data;
    
    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public int hashCode() {
        return Objects.hash(data);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Pocket other = (Pocket) obj;
        return Objects.equals(data, other.data);
    }

    @Override
    public String toString() {
        return "Pocket [data=" + data + "]";
    }
}
