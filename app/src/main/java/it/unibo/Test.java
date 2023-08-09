package it.unibo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import it.unibo.common.Constants;
import it.unibo.connection.ConnectionProvider;
import it.unibo.controller.api.Controller;
import it.unibo.controller.impl.ControllerImpl;
import it.unibo.view.MainFrame;

public class Test {

    public static void main(final String[] args) {
        final Controller controller = new ControllerImpl();
        final Set<List<String>> set = new HashSet<>();
        List<String> list1 = List.of("a", "b", "c");
        List<String> list2 = new ArrayList<>();
        list2.add("a");
        list2.add("b");
        list2.add("c");
        set.add(list1);
        set.add(list2);
        System.out.println(set);
    }

}
