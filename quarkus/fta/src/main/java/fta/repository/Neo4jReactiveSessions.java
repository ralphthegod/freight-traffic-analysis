package fta.repository;

import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Record;
import org.neo4j.driver.reactive.ReactiveResult;
import org.neo4j.driver.reactive.ReactiveSession;

import java.util.concurrent.Flow;

public class Neo4jReactiveSessions {

    public static Multi<Record> executeRead(final Driver driver, final String query) {
        return Multi.createFrom().resource(() -> driver.session(ReactiveSession.class),
            reactiveSession ->
                reactiveSession.executeRead(reactiveTransactionContext -> {
                    final Flow.Publisher<ReactiveResult> resultPublisher = reactiveTransactionContext.run(query);
                    return Multi.createFrom().publisher(resultPublisher).flatMap(ReactiveResult::records);
                })
        ).withFinalizer(Neo4jReactiveSessions::reactiveSessionFinalizer);
    }

    public static Uni<Void> reactiveSessionFinalizer(final ReactiveSession session) {
        return Uni.createFrom().publisher(session.close());
    }
}
