package backend.persistence.entity;

import io.quarkus.runtime.annotations.RegisterForReflection;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "payments")
@RegisterForReflection
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {
    @Id
    @GeneratedValue(generator = "payments_sequence", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "payments_sequence", sequenceName = "payments_sequence", allocationSize = 1)
    @Column(nullable = false)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "order_id")
    private Order order;

    @Column(length = 50, nullable = false)
    private String provider;

    @Enumerated(EnumType.STRING)
    @Column(length = 30, nullable = false)
    private PaymentStatus status;

    public enum PaymentStatus {
        PENDING,
        PROCESSING,
        SUCCEEDED,
        FAILED,
        CANCELED,
        AUTHORIZED,
        CAPTURED,
        REFUNDED,
        PARTIALLY_REFUNDED,
        EXPIRED
    }
}
