package it.unibo.common;

/**
 * A standard counter, used to count in enclosed spaces where primitive (int)
 * counters should be final and can't be incremented.
 */
public class Counter {

    private int value;

    /**
     * Creates an instance of {@code Counter} and sets it to 0.
     */
    public Counter() {
        this.value = 0;
    }

    /**
     * Creates an instance of {@code Counter} and initializes the value.
     * 
     * @param startValue the starting value
     */
    public Counter(final int startValue) {
        this.value = startValue;
    }

    /**
     * Increments the value by 1.
     */
    public void increment() {
        this.value++;
    }

    /**
     * Retrieves the current value.
     * 
     * @return the current value
     */
    public int getValue() {
        return this.value;
    }

    /**
     * Retrieves the current value and then increments it.
     * 
     * @return the current value
     */
    public int getValueAndIncrement() {
        final int c = getValue();
        increment();
        return c;
    }

    /**
     * Resets the value to 0.
     */
    public void reset() {
        this.value = 0;
    }

}
