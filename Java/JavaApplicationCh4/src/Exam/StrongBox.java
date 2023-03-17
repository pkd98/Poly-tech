package Exam;

import java.util.Objects;

public class StrongBox<T> {
    private T data;
    private KeyType keyType;
    private int usedCount;

    public StrongBox(T data, KeyType keyType) {
        this.data = data;
        this.keyType = keyType;

        switch (this.keyType) {
            case PADLOCK:
                this.usedCount = 1024;
                break;
            case BUTTON:
                this.usedCount = 10000;
                break;
            case DIAL:
                this.usedCount = 30000;
                break;
            case FINGER:
                this.usedCount = 1000000;
        }
    }
    
    public StrongBox(KeyType keyType) {
        this(null, keyType);
    }

    public T get() {
        usedCount--;
        if (this.usedCount > 0) {
            return null;
        } else {
            return data;
        }
    }

    public void put(T data) {
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
        StrongBox other = (StrongBox) obj;
        return Objects.equals(data, other.data);
    }

    @Override
    public String toString() {
        return "StrongBox [data=" + data + "]";
    }
}
