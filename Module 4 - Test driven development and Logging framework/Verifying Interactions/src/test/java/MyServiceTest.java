package org.example;

import org.junit.jupiter.api.Test;

import static jdk.internal.classfile.impl.verifier.VerifierImpl.verify;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    public void testVerifyInteraction() {

        // Step 1: Create Mock Object
        ExternalApi mockApi = mock(ExternalApi.class);

        // Step 2: Create Service
        MyService service = new MyService(mockApi);

        // Step 3: Call Method
        service.fetchData();

        // Step 4: Verify Interaction
        verify(mockApi).getData();
    }
}