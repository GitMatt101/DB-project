package it.unibo.common;

/**
 * A standard counter, used to count in enclosed spaces where primitive (int)
 * counters should be final and can't be incremented.
 */
public class Counter {

    private int counter;

    /**
     * Creates an instance of {@code Counter} and sets it to 0.
     */
    public Counter() {
        this.counter = 0;
    }

    /**
     * Increments the counter by 1.
     */
    public void increment() {
        this.counter++;
    }

    /**
     * Retrieves the current counter value.
     * 
     * @return the current counter value
     */
    public int getCounter() {
        return this.counter;
    }

    /**
     * Retrieves the current counter value and then increments it.
     * 
     * @return the current counter value
     */
    public int getCounterAndIncrement() {
        final int c = getCounter();
        increment();
        return c;
    }

    /**
     * Resets the counter to 0.
     */
    public void reset() {
        this.counter = 0;
    }

}
